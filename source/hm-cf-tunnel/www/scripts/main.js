const $ = document.getElementById.bind(document);

async function configure() {
  const token = $("configure-token").value;

  // Execute the configure command with token.
  const url = `api/configure.cgi?token=${token}`;
  const response = await fetch(url);

  // Show command result in the command output.
  $("command-output").value = await response.text();
}

$("configure-form").addEventListener("submit", configure);
