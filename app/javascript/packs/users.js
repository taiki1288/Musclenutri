document.addEventListener('DOMContentLoaded', function() {
  const tabs = document.getElementsByClassName('tabs_item');
  for(let i = 0; i < tabs.length; i++) {
    tabs[i].addEventListener('click', tabSwitch);
  }

  function tabSwitch(){
    document.getElementsByClassName('active')[0].classList.remove('active');
    this.classList.add('active');
    document.getElementsByClassName('is-show')[0].classList.remove('is-show');
    arrayTabs = Array.prototype.slice.call(tabs);
    index = arrayTabs.indexOf(this);
    document.getElementsByClassName('panel')[index].classList.add('is-show');
  };
});