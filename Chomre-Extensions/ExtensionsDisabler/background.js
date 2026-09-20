const STATE_KEY = "toggleState";

async function getOtherExtensions() {
  const all = await chrome.management.getAll();

  return all.filter(
    (ext) =>
      ext.type === "extension" &&
      ext.id !== chrome.runtime.id
  );
}

async function getState() {
  const data = await chrome.storage.local.get(STATE_KEY);
  return data[STATE_KEY] || null;
}

async function setState(state) {
  await chrome.storage.local.set({
    [STATE_KEY]: state
  });
}

async function disableAll() {
  const existingState = await getState();

  if (existingState) {
    console.log("Privacy mode is already active.");
    return;
  }

  const extensions = await getOtherExtensions();

  // Save the exact original state of every other extension.
  const savedStates = extensions.map((ext) => ({
    id: ext.id,
    name: ext.name,
    enabled: ext.enabled
  }));

  await setState({
    active: true,
    extensions: savedStates
  });

  const failures = [];

  for (const ext of extensions) {
    if (!ext.enabled) continue;

    try {
      await chrome.management.setEnabled(ext.id, false);
      console.log(`Disabled: ${ext.name}`);
    } catch (error) {
      failures.push({
        name: ext.name,
        error: error.message
      });

      console.warn(`Could not disable ${ext.name}:`, error.message);
    }
  }

  console.log(
    failures.length
      ? `Privacy mode enabled with ${failures.length} failure(s).`
      : "Privacy mode enabled. Other extensions disabled."
  );
}

async function restoreAll() {
  const state = await getState();

  if (!state) {
    console.log("Privacy mode is not active.");
    return;
  }

  const failures = [];

  for (const saved of state.extensions) {
    try {
      await chrome.management.setEnabled(saved.id, saved.enabled);
      console.log(
        `${saved.enabled ? "Restored" : "Kept disabled"}: ${saved.name}`
      );
    } catch (error) {
      failures.push({
        name: saved.name,
        error: error.message
      });

      console.warn(`Could not restore ${saved.name}:`, error.message);
    }
  }

  await chrome.storage.local.remove(STATE_KEY);

  console.log(
    failures.length
      ? `Restoration finished with ${failures.length} failure(s).`
      : "All extensions restored to their previous states."
  );
}

async function toggleExtensions() {
  const state = await getState();

  if (state) {
    await restoreAll();
  } else {
    await disableAll();
  }
}

chrome.commands.onCommand.addListener(async (command) => {
  if (command === "toggle-extensions") {
    await toggleExtensions();
  }
});