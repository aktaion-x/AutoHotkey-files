chrome.commands.onCommand.addListener((command) => {
      if (command === "open-readest") {
        chrome.tabs.create({
            url: "https://web.readest.com/"
        });
    } else if (command === "open-chatgpt") {
        chrome.tabs.create({
            url: "https://chatgpt.com/"
        });
    } else if (command === "open-definer-option") {
        chrome.tabs.create({
            url: "chrome-extension://hlicibdjngocokkjcoebgfifoomniknn/options/options.html#/history/list?size=50"
        });
    }

});
// Deprecated
/* 
chrome.runtime.onMessage.addListener((message) => {
    if (message.action === "openReadest") {
        chrome.tabs.create({
            url: "https://web.readest.com/"
        });
    } else if (message.action === "openChatGPT") {
        chrome.tabs.create({
            url: "https://chatgpt.com/"
        });
    } else if (message.action === "openDefinerHistory") {
        chrome.tabs.create({
            url: "chrome-extension://hlicibdjngocokkjcoebgfifoomniknn/options/options.html#/history/list?size=50"
        });
    }
});
 */