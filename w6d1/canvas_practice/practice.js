document.addEventListener("DOMContentLoaded", function(){
  const canvas = document.getElementById('mycanvas');
  canvas.height = 500;
  canvas.width = 500;

  const ctx = canvas.getContext('2d');
  ctx.fillStyle = 'gray';
  ctx.fillRect(0, 0, 500, 500);

  ctx.beginPath();
  ctx.arc(250, 250, 138, 0, 2*Math.PI);
  ctx.arc(300, 200, 28, 0, 2*Math.PI);
  ctx.arc(200, 200, 28, 0, 2*Math.PI);
  ctx.strokeStyle = 'black';
  ctx.lineWidth = 7;
  ctx.stroke();
});
