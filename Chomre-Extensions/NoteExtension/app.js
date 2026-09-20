const svg = `<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M280-120q-33 0-56.5-23.5T200-200v-520h-40v-80h200v-40h240v40h200v80h-40v520q0 33-23.5 56.5T680-120H280Zm400-600H280v520h400v-520ZM360-280h80v-360h-80v360Zm160 0h80v-360h-80v360ZM280-720v520-520Z"/></svg>`

let notes = [];
let fileHandle = null;
let hasUnsavedChanges = false;

const openBtn = document.getElementById("openBtn");
// const emptyOpenBtn = document.getElementById("emptyOpenBtn");
const saveBtn = document.getElementById("saveBtn");
const addBtn = document.getElementById("addBtn");

const toggleView = document.getElementById('toggleView')
const notesContainer = document.getElementById("notesContainer");
const emptyState = document.getElementById("emptyState");
const noteCount = document.getElementById("noteCount");
const fileName = document.getElementById("fileName");
const status = document.getElementById("status");

openBtn.addEventListener("click", openFile);
emptyState.addEventListener("click", openFile);
saveBtn.addEventListener("click", saveFile);
addBtn.addEventListener("click", addNote);


/**
 * Open JSON file
 */
async function openFile() {
    try {
        const [handle] = await window.showOpenFilePicker({
            multiple: false,

            types: [
                {
                    description: "JSON files",
                    accept: {
                        "application/json": [".json"]
                    }
                }
            ]
        });

        fileHandle = handle;

        const file = await handle.getFile();
        const text = await file.text();

        const parsed = JSON.parse(text);

        if (!Array.isArray(parsed)) {
            throw new Error("The JSON file must contain an array.");
        }

        validateNotes(parsed);

        notes = parsed;

        fileName.textContent = file.name;

        render();

        saveBtn.disabled = false;
        addBtn.disabled = false;

        showStatus("File loaded successfully.");

    } catch (error) {
        if (error.name === "AbortError") {
            return;
        }

        console.error(error);

        showStatus(
            error.message || "Could not open the file.",
            true
        );
    }
}


/**
 * Validate JSON structure
 *
 * Expected:
 *
 * [
 *   {
 *     "timestamp": "...",
 *     "note": "..."
 *   }
 * ]
 */
function validateNotes(data) {
    for (let i = 0; i < data.length; i++) {
        const item = data[i];

        if (
            typeof item !== "object" ||
            item === null ||
            !("timestamp" in item) ||
            !("note" in item)
        ) {
            throw new Error(
                `Invalid note at index ${i}. Each item must contain timestamp and note.`
            );
        }
    }
}


/**
 * Render all notes
 */
function render() {

    notesContainer.innerHTML = "";

    noteCount.textContent = notes.length;

    emptyState.style.display =
        notes.length === 0 ? "block" : "none";
    console.log(notes)
    notes.sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp));
    for (let index = 0; index < notes.length; index++) {
        const note = notes[index];

        const card = document.createElement("div");
        card.className = "note-card";

        // Timestamp
        const timestampInput = document.createElement("input");

        timestampInput.className = "timestamp";
        timestampInput.type = "text";
        timestampInput.value = note.timestamp ?? "";

        timestampInput.addEventListener("input", () => {
            notes[index].timestamp = timestampInput.value;
        });

        // Note
        const noteInput = document.createElement("textarea");

        noteInput.className = "note-input";
        noteInput.placeholder = "Write your note...";
        noteInput.value = note.note ?? "";

        noteInput.addEventListener("input", () => {
            notes[index].note = noteInput.value;
            changeSaveStatus(true);
        });

        // Delete button
        const deleteButton = document.createElement("button");

        deleteButton.className = "btn danger";
        deleteButton.innerHTML = svg;

        deleteButton.addEventListener("click", () => {
            deleteNote(index);
        });

        // Container for card elements
        const cardContainer = document.createElement("div");

        cardContainer.appendChild(timestampInput);
        cardContainer.appendChild(deleteButton);
        cardContainer.appendChild(noteInput);

        card.appendChild(cardContainer)

        notesContainer.appendChild(card);
    }
}


/**
 * Add a new note
 */
function addNote() {
    const now = new Date();
    notes.unshift({
        timestamp: new Date(
            now.getTime() - now.getTimezoneOffset() * 60000
        ).toISOString().slice(0, 19),
        note: ""
    });

    changeSaveStatus(true);

    render();

    showStatus("New note added.");

    // Focus the new note
    const firstNote =
        notesContainer.querySelector(".note-input");

    if (firstNote) {
        firstNote.focus();
    }
}


/**
 * Delete note
 */
function deleteNote(index) {
    /*     const note = notes[index];
    
        const preview =
            String(note.note || "").slice(0, 50);
    
        const confirmed = confirm(
            `Delete this note${preview ? `?\n\n"${preview}"` : "?"}`
        );
    
        if (!confirmed) {
            return;
        }
     */
    notes.splice(index, 1);

    changeSaveStatus(true);

    render();

    showStatus("Note deleted.");
}


/**
 * Save to the ORIGINAL file
 */
async function saveFile() {
    if (!fileHandle) {
        showStatus("No file is open.", true);
        return;
    }

    try {
        /*
         * The permission may have expired or the user may
         * have revoked it. Ask for write permission again.
         */
        const permission = await fileHandle.requestPermission({
            mode: "readwrite"
        });

        if (permission !== "granted") {
            throw new Error(
                "Write permission was not granted."
            );
        }

        const writable =
            await fileHandle.createWritable();

        const json = JSON.stringify(notes, null, 2);

        await writable.write(json);

        await writable.close();

        changeSaveStatus(false);

        showStatus("Saved successfully.");

    } catch (error) {
        console.error(error);

        showStatus(
            error.message || "Could not save the file.",
            true
        );
    }
}


/**
 * Small status notification
 */
let statusTimer;

function showStatus(message, isError = false) {
    clearTimeout(statusTimer);

    status.textContent = message;

    status.classList.toggle("error", isError);
    status.classList.add("show");

    statusTimer = setTimeout(() => {
        status.classList.remove("show");
    }, 2500);
}

function changeSaveStatus(change) {
    if (change) {
        hasUnsavedChanges = true;
        document.body.classList.add('unsaved');
        return
    }
    hasUnsavedChanges = false;
    document.body.classList.remove('unsaved');
}

document.addEventListener("keydown", async (event) => {
    if (event.ctrlKey && event.key === "s") {
        event.preventDefault();
        await saveFile();
    }
});

document.addEventListener("keydown", async (event) => {
    if (event.ctrlKey && event.key === "o") {
        event.preventDefault();
        await openFile();
    }
});

window.addEventListener("beforeunload", (event) => {
    if (!hasUnsavedChanges) {
        return;
    }
    event.preventDefault();
    event.returnValue = "";
});

toggleView.addEventListener("change", () => {
    console.log('fired');
    document.body.classList.toggle('list')
})
