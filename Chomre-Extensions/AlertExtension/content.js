const title = "Don't dismiss, Don't disable!";
const messages = "Free you are, no police on you. Alone you are, no one can help you. If you don't overcome yourself, there is no hope for you"
// const answerList = ["no lies, only truth", "no weakness, only control", "no comfort, only discipline"]
const finalAnswer = "I'm in control, I'm not lying"

async function alertMessage() {
  let answer = finalAnswer;

  // Prevent the alert from being injected twice.
  if (window.__customTabAlertLoaded) return;
  window.__customTabAlertLoaded = true;

  const host = document.createElement("div");
  host.id = "__custom_tab_alert__";

  // Play the Audio
  const audio = playAudio()

  // Put the host at the very top of the document.
  document.documentElement.appendChild(host);
  const shadow = host.attachShadow({ mode: "closed" });

  shadow.innerHTML = `
<style>
  :host {
    all: initial;
    direction: ltr;
  }

  .overlay {
    position: fixed;
    inset: 0;
    z-index: 2147483647;

    display: flex;
    align-items: baseline;
    justify-content: center;

    background: rgba(0, 0, 0, 0.90);

    font-family:
      -apple-system,
      BlinkMacSystemFont,
      "Segoe UI",
      Roboto,
      Helvetica,
      Arial,
      sans-serif;

    animation: fadeIn 120ms ease-out;
    padding-top: 15vh;
  }

  .dialog {
    // width: min(420px, calc(100vw - 40px));
    box-sizing: border-box;
    padding: 24px;
    background: #111111;
    color: #dddddd;
    border-radius: 12px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.999);
    animation: dialogIn 120ms ease-out;
    outline: none;
    border: 1px solid #222;
  }

.title {
    margin: 0 0 40px;
    font-size: 28px;
    font-weight: 600;
    text-decoration: underline;
}

.message.placeholder {
    user-select: none;
    opacity: 0;
    position: relative;
    z-index: -1 !important;
}
.message-container {
    position: relative
}
.message {
    margin: 0 0 24px;
    font-size: 20px;
    line-height: 1.5;
    font-style: italic;
    white-space: pre-line;
    position: absolute;
    top: 0;
}

   .form > div {
   display: flex;
    gap: 10px;
    margin-top: 10px;
  }

  .form .form-text i {
  text-decoration: underline;
  color: #ff5858;
  }

  .form input {
    background: transparent;
    border: 1px solid #aaa;
    border-radius: 7px;
    width: 100%;
    color: #eeeeee;
    font-size: 16px;
    outline: none;
    padding: 0 10px;
        transition: .3s;
  }

  .form input:focus {
    background: #000;
  }

  button {
appearance: none;
    border: 0;
    padding: 9px 20px;
    border-radius: 7px;
    background: transparent;
    color: white;
    font: inherit;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    outline: 1px solid #fff;
    transition: .3s;
  }

  button:hover {
    background: #000;
  }

  .error {
    font-size: 14px;
    padding: 5px 0 0;
    color: #ff5858;
    opacity: 0;
    transition: .3s;
  }
    .error.active {
    opacity: 1;
    }

  @keyframes fadeIn {
    from {
      opacity: 0;
    }

    to {
      opacity: 1;
    }
  }

  @keyframes dialogIn {
    from {
      opacity: 0;
      transform: scale(0.96);
    }

    to {
      opacity: 1;
      transform: scale(1);
    }
  }
    .fade-out {
  animation: scaleOut 0.4s ease-out forwards;
}

@keyframes scaleOut {
  from {
    opacity: 1;
  }
  to {
    opacity: 0;
  }
}
</style>

<div class="overlay" role="presentation">
  <div class="dialog" role="alertdialog" aria-modal="true" aria-labelledby="title" aria-describedby="message"
    tabindex="-1">
    <h2 class="title" id="title">${title}</h2>

    <div class="message-container">
      <p class="message" id="message"></p>
      <p class="message placeholder">${messages.replaceAll('.', '\n')}</p>
    </div>
    <div class="form">
      <span class="form-text">Write the <i>truth</i>, only the <i>truth</i> can save you.</span>
      <div>
      <input type="text" name="answer" autofocus data-correct-answer="${answer}" />
      <button id="ok" type="button">
        OK
      </button>
      </div>
    </div>
    <div class="error">Wrong Answer!!</div>
  </div>
</div>
  `;

  // Fill messages
  typeWriterEffect(messages.replaceAll('.', '\n'), shadow.querySelector('#message'), 0)

  const overlay = shadow.querySelector(".overlay");
  // const dialog = shadow.querySelector(".dialog");
  const button = shadow.querySelector("#ok");
  const input = shadow.querySelector(".form input")

  function close() {
    overlay.classList.add('fade-out')
    audio.pause();
    setTimeout(() => {
      host.remove();
    }, 400);
  }

  // Don't allow clicks to reach the underlying page.
  overlay.addEventListener("click", (event) => {
    if (event.target == button) {
      checkForm()
    }
    event.stopPropagation();
  }, true);
  // Pressing Enter
  document.addEventListener("keydown", (event) => {
    if (!host.isConnected) return;

    if (event.key === "Enter") {
      event.preventDefault();
      event.stopPropagation();
      checkForm()
    } else if (event.key.toLowerCase() === 'p' || event.key === 'ح') {
      event.preventDefault();
      event.stopPropagation();
      input.focus();
    }
  }, true);

  // Checking the answer
  function checkForm() {
    if (input.value && input.value.toLowerCase() == answer.toLocaleLowerCase()) {
      setTimeout(() => {
        window.__customTabAlertLoaded = false;
        alertMessage()
      }, 300000);
      close()
    } else {
      const error = shadow.querySelector('.error')
      error.classList.add('active')
    }
  }

  // Focus the dialog as soon as possible.
  requestAnimationFrame(() => {
    input.focus();
  });
};

function typeWriterEffect(text, container, i) {
  let characterIndex = i;

  if (characterIndex < text.length) {
    // Append the next letter to the existing inner content
    container.innerHTML += text.charAt(characterIndex);
    characterIndex++;

    // Call the function recursively after a specific delay speed
    setTimeout(() => {
      typeWriterEffect(text, container, characterIndex)
    }, 25); // 75ms typing speed
  }
}



function playAudio() {
  const audio = new Audio(chrome.runtime.getURL("audio.mp3"));

  audio.volume = 0.7;
  audio.play().catch((err) => { console.log('error:', err) });

  return audio;
}

alertMessage()
