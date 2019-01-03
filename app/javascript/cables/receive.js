import { setCallback } from "./alerts";
import { showToast } from "../toast";
setCallback(message => {
  //console.log(message);
  showToast(message);
});