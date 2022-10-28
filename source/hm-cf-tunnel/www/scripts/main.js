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

$("configure-form").addEventListener("submit", configure);
