const $ = document.getElementById.bind(document);

async function configure() {
  disableConfigureForm();

  const token = $("configure-token").value;

  // Execute the configure command with token.
  const url = `api/configure.cgi?token=${token}`;
  const response = await fetch(url);

  if (response.ok) {
    showConfigureOverlay("success");
  } else {
    showConfigureOverlay("failure");
  }
}

function disableConfigureForm(disabled = true) {
  $("configure-form").disabled = disabled;
  $("configure-submit").disabled = disabled;
}

async function loadStatus() {
  const response = await fetch("api/status.cgi");

  if (response.ok) {
    const { code, status } = await response.json();
    const running = code == 0, stopped = !running;

    $("status").classList.toggle("running", running);
    $("status").classList.toggle("stopped", stopped);
    
    $("status").textContent = status;
  }
}

async function loadVersion() {
  const response = await fetch("api/version.cgi");

  if (!response.ok) {
    throw new Error("Failed to load version.");
  }

  $("version").textContent = await response.text();
}

function showConfigureOverlay(type, visible = true, timeout = 5000) {
  if (visible) {
    disableConfigureForm();

    $(`configure-overlay-${type}`).style.visibility = "visible";

    // Hide the overlay again after the configured timeout.
    setTimeout(() => showConfigureOverlay(type, false), timeout);
  } else {
    $(`configure-overlay-${type}`).style.visibility = "hidden";

    disableConfigureForm(false);
  }
}

loadStatus().then(() => setInterval(loadStatus, 1000));
loadVersion().catch(() => loadVersion());

$("configure-form").addEventListener("submit", configure);
