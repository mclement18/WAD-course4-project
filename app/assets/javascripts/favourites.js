const Favourite = {};

Favourite.buildRemoveLink = function(tipId, deletePath, deleteText, swapText) {
  const link = document.createElement('a');
  link.href = deletePath;
  link.id = `remove-favourite-tip-${tipId}`;
  link.className = 'btn btn-success removeFavourites';
  link.role = 'button';
  link.rel = 'nofollow';
  link.setAttribute('data-remote', 'true');
  link.setAttribute('data-method', 'delete');
  link.setAttribute("data-text-swap", swapText);
  link.textContent = deleteText;

  Favourite.addListenersToLink(link);

  return link;
};

Favourite.buildAddForm = function(tipId, addPath, addText) {
  const button = document.createElement('button');
  button.name = 'button';
  button.type = 'submit';
  button.className = 'btn btn-outline-success';
  button.textContent = addText;

  const tipIdInput = document.createElement('input');
  tipIdInput.type = 'hidden';
  tipIdInput.name = 'tip_id';
  tipIdInput.id = 'tip_id';
  tipIdInput.value = tipId;

  const hiddenInput = document.createElement('input');
  hiddenInput.name = 'utf8';
  hiddenInput.type = 'hidden';
  hiddenInput.value = '✓';

  const form = document.createElement('form');
  form.id = `add-favourite-tip-${tipId}`;
  form.action = addPath;
  form.method = 'post';
  form.style = 'display: inline-block;';
  form.setAttribute('accept-charset', 'UTF-8');
  form.setAttribute('data-remote', 'true');

  form.appendChild(hiddenInput);
  form.appendChild(tipIdInput);
  form.appendChild(button);

  return form;
};

Favourite.renderButton = function(tipId, path, text, type, swapText='Remove') {
  if (type === 'add') {
    var newButton = Favourite.buildAddForm(tipId, path, text);
    var oldButton = document.getElementById(`remove-favourite-tip-${tipId}`);
  } else if (type === 'remove') {
    var newButton = Favourite.buildRemoveLink(tipId, path, text, swapText);
    var oldButton = document.getElementById(`add-favourite-tip-${tipId}`);
  }

  const parent = oldButton.parentElement;
  parent.removeChild(oldButton);
  parent.appendChild(newButton);
};

Favourite.changeLinkText = function(link, type) {
  if (type == "on") {
    link.setAttribute("data-text-original", link.innerHTML);
    link.innerHTML = link.getAttribute("data-text-swap");
  } else if (type == "out") {
    link.innerHTML = link.getAttribute("data-text-original");
  }
};

Favourite.addListenersToLink = function(link) {
  link.addEventListener("mouseover", () => {
    Favourite.changeLinkText(link, "on");
  });
  link.addEventListener("focus", () => {
    Favourite.changeLinkText(link, "on");
  });
  link.addEventListener("mouseout", () => {
    Favourite.changeLinkText(link, "out");
  });
  link.addEventListener("focusout", () => {
    Favourite.changeLinkText(link, "out");
  });
};

Favourite.makeRemoveLinksTextInteractive = function() {
  document.querySelectorAll('.removeFavourites').forEach(link => {
    Favourite.addListenersToLink(link);
  });
};
