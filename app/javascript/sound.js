import 'ion-sound'
import aac from './media/windchimes.aac'
const sound = window.ion.sound;
const sound_name = 'windchimes';
console.log(aac);
sound({
  sounds: [
    {
      name: sound_name,
      supported: ['aac']
    }
  ],
  path: '/packs/audio/',
  //supported: ['aac'],
  volume: 0.5,
  preload: true
});

export function preload() {
  sound.preload(sound_name);
}

export function play() {
  sound.play(sound_name);
}

export function stop() {
  sound.stop(sound_name);
}
