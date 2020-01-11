const Tip = {};

Tip.removeFromPage = function(tipId) {
  document.getElementById('tip-' + tipId).remove();
  
  const notice = document.createTextNode('Tip was successfully destroyed.');
  document.getElementById('notice').appendChild(notice);
};
