// Disable shortcut on discord.js

// ==UserScript==
// @name         Disable Ctrl+F in Discord
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  在 Discord 上禁用 Ctrl + F 的搜尋快捷鍵
// @author       kota
// @match        https://discord.com/channels/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=discord.com
// @grant        none
// ==/UserScript==

(function () {
    'use strict';

    // source code: https://superuser.com/a/670040

    keycodes = [70];
    // key F        查表: https://blogs.longwin.com.tw/lifetype/key_codes.html

    (window.opera ? document.body : document).addEventListener('keydown', function (e) {
        // alert(e.keyCode ); //uncomment to find more keyCodes
        if (keycodes.indexOf(e.keyCode) != -1 && e.ctrlKey) {
            e.cancelBubble = true;
            e.stopImmediatePropagation();
            // alert("Gotcha!"); //ucomment to check if it's seeing the combo
        }
        return false;
    }, !window.opera);

})();
