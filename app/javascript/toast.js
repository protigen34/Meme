import { play, stop } from './sound';
let toastr = require('toastr');
window.toastr = toastr;

toastr.options = {
  closeButton: true,
  debug: false,
  newestOnTop: false,
  progressBar: false,
  positionClass: "toast-bottom-right",
  preventDuplicates: false,
  showDuration: "300",
  hideDuration: "1000",
  timeOut: 0,
  extendedTimeOut: 0,
  showEasing: "swing",
  hideEasing: "linear",
  showMethod: "fadeIn",
  hideMethod: "fadeOut",
};

export function showToast(medInfo) {
  let options = {
    onHidden: () => {
      stop();
    },
    onShown: () => {
      play();
    }
  };
  options = Object.assign({}, options, medInfo.options || {});
  return toastr["info"](medInfo.title, medInfo.text, options);
}

window.showToast = showToast;