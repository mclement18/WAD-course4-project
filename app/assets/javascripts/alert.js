const Alert = {};

Alert.createDismissButton = function() {
  const cross = document.createElement('span');
  cross.setAttribute('aria-hidden', 'true');
  cross.innerHTML = '&times;';

  const button = document.createElement('button');
  button.className = 'close';
  button.type = 'button';
  button.setAttribute('data-dismiss', 'alert');
  button.setAttribute('aria-label', 'Close');
  button.appendChild(cross);

  return button;
};

Alert.createContent = function(message) {
  const content = document.createElement('p');
  content.className = 'mb-0';
  content.textContent = message;

  return content;
};

Alert.create = function(message, type, id) {
  const dismissButton = Alert.createDismissButton();

  const alertContent = Alert.createContent(message);

  const alert = document.createElement('div');
  alert.id = id;
  alert.role = type;
  alert.className = 'alert alert_and_notice alert-dismissible fade show';

  if (type === 'alert') {
    alert.classList.add('alert-danger');
  } else if (type === 'notice') {
    alert.classList.add('alert-success');
  }

  alert.appendChild(alertContent);
  alert.appendChild(dismissButton);

  return alert;
};

Alert.render = function(message, type, id) {
  const alert = Alert.create(message, type, id);

  const header = document.querySelector('header');
  header.parentElement.insertBefore(alert, header.nextElementSibling);

  Alert.autoDismiss(id);
};

Alert.autoDismiss = function(id) {
  setTimeout(() => {
    $(`#${id}`).alert('close')
  }, 10000);
};
