const Tip = {};

Tip.removeFromPage = function(tipId, noTipsMessage) {
  document.getElementById('tip-' + tipId).remove();

  Tip.displayNoTips(noTipsMessage);
};

Tip.displayNoTips = function(message) {
  const tipsList = document.getElementById('tipsList');
  if (tipsList.childElementCount === 0) {
    const noTips = document.createElement('p');
    noTips.className = 'no-results mt-5 mb-5';
    noTips.textContent = message;

    tipsList.appendChild(noTips);
  }
};
