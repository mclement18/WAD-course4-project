const User = {};

User.buildLink = function(user) {
  const avatar = document.createElement('img');
  avatar.src = user.avatar_url;
  avatar.className = 'avatar-xs';

  const name = document.createTextNode(user.name);

  const link = document.createElement('a');
  link.appendChild(avatar);
  link.appendChild(name);
  link.href = user.path;

  return link;
};
