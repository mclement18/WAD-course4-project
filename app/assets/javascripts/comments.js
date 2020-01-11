const Comment = {};

Comment.build = function(comment) {
  const text1 = document.createTextNode(comment.text1);
  const text2 = document.createTextNode(comment.text2);
  const userLink = User.buildLink(comment.user);
  
  const footer = document.createElement('footer');
  footer.appendChild(text1);
  footer.appendChild(userLink);
  footer.appendChild(text2);
  footer.className = 'blockquote-footer';
  
  const body = document.createElement('p');
  body.className = 'mb-0';
  body.textContent = comment.body;

  const newComment = document.createElement('blockquote');
  newComment.appendChild(body);
  newComment.appendChild(footer);
  newComment.className = 'blockquote';

  return newComment;
};

Comment.render = function(comment) {
  const newComment = Comment.build(comment);
  document.getElementById('commentsList').appendChild(newComment);
  document.getElementById('comment_body').value = '';
};
