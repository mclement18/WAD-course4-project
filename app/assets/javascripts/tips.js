const Tip = {};

Tip.removeFromPage = function(tipId) {
  document.getElementById('tip-' + tipId).remove();
};
