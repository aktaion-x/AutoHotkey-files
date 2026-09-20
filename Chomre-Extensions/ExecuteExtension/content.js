const sites = [

    {
        domain: "www.google.com",

        run() {
            console.log("Google script");
        }
    },

    {
        domain: "web.readest.com",

        run() {
            console.log("Readest script");


            window.addEventListener("keydown", event => {
                document.body.setAttribute("tabindex", "-1");
                document.body.focus();
                document.body.removeAttribute("tabindex");
                const selectedElement = document.querySelector('#titlebar-close')
                if (
                    event.shiftKey &&
                    event.key.toLowerCase() === "q"
                ) {

                    if (selectedElement) {
                        console.log('condition are met');
                        selectedElement.click();
                    }
                }
            });
        }
    }

];


const hostname = location.hostname;

const site = sites.find(
    site => site.domain === hostname
);

if (site) {
    site.run();
}

console.log('running from MyPersonalExtension');

// Deprectated
/* 
window.addEventListener("keydown", event => {
    console.log('running the listener', event)

    if (
        event.ctrlKey &&
        event.altKey &&
        event.key.toLowerCase() === "1"
    ) {
        console.log('1 is pressed');
        chrome.runtime.sendMessage({
            action: "openReadest"
        })
    } else if (
        event.ctrlKey &&
        event.altKey &&
        event.key.toLowerCase() === "2"
    ) {
        console.log('2 is pressed');
        chrome.runtime.sendMessage({
            action: "openChatGPT"
        })

    } else if (
        event.ctrlKey &&
        event.altKey &&
        event.key.toLowerCase() === "3"
    ) {
        console.log('3 is pressed');
        chrome.runtime.sendMessage({
            action: "openDefinerHistory"
        });

    }
});
 */