// refresh_every_10_seacond.js

// ==UserScript==
// @name         Refesh every 10 seacond
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  能自動刷新頁面的小工具，要暫停的話須手動從 Tampermonkey 將腳本關閉
// @author       kota
// @match        https://meet.google.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=google.com
// @grant        none
// ==/UserScript==

// 可將 line 9 的 match 網址換成你要的網站
(function () {
    'use strict';

    var sec = 10;
    // 秒數

    setTimeout(function () { window.location.href = window.location.href; }, sec * 1000);

})();