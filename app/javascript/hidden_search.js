window.addEventListener('load', () => {
  const pullDownButton = document.getElementById("pull-down-btn");
  const pullDown = document.getElementById("pull-down");
  pullDownButton.addEventListener('mouseover', () => {
    pullDownButton.setAttribute("style", "border :1px solid #088;");
  });
  pullDownButton.addEventListener('mouseout', () => {
    pullDownButton.removeAttribute("style", "border :1px solid #088");
  });
  pullDownButton.addEventListener('click', () =>{
    if (pullDown.getAttribute("style") == "display:block;") {
      pullDown.removeAttribute("style", "display:block;")
    } else {
      pullDown.setAttribute("style", "display:block;")
    };
  });
});