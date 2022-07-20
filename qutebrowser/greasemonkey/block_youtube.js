// ==UserScript==
// u/name         Auto Skip YouTube Ads
// u/version      1.0.0
// u/description  Speed up and skip YouTube ads automatically
// u/author       jso8910
// u/match        *://*.youtube.com/*
// u/exclude      *://*.youtube.com/subscribe_embed?*
// ==/UserScript==
setInterval(() => {
  document
    .querySelectorAll('.videoAdUiSkipButton,.ytp-ad-skip-button')
    .forEach((b) => b.click())
  if (document.querySelector('.ad-showing')) {
    document.querySelectorAll('video').forEach((v) => (v.playbackRate = 16))
  }
  document
    .querySelectorAll('#player-ads')
    .forEach((sidebarAd) => sidebarAd.remove())
  document
    .querySelectorAll('#masthead-ad')
    .forEach((startPageTopAd) => startPageTopAd.remove())
}, 50)
