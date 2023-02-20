// type_in.js
// 幾年前為了在 Google Meet 上間隔一段時間就自動輸入文字而寫的腳本，不確定還能不能用XD
// 在 DevTools 的 Console 裡貼上就可以測試了

function check(send_msg) {
    // 文字框
    let txt_ara = document.querySelector('#bfTqV');

    if (txt_ara) {
        let msg = `${send_msg}`;
        txt_ara.value = msg;
    }

    // 送出按鈕
    let btn = document.querySelector('#ow3 > div.T4LgNb > div > div:nth-child(9) > div.crqnQb > div.R3Gmyc.qwU8Me > div.WUFI9b > div.hWX4r > div > div.BC4V9b > span > button');

    if (btn) {
        btn.disabled = false;
        btn.click();
    }
}

function check_time() {
    const date = new Date();
    const hour = date.getHours();
    const min = date.getMinutes();
    const sec = date.getSeconds();

    // 如果時、分、秒 >= 9 的話就在前面加上0，不是的話就不加。並轉為字串。
    let sh = hour > 9 ? String(hour) : '0' + String(hour);
    let sm = min > 9 ? String(min) : '0' + String(min);
    let ss = sec > 9 ? String(sec) : '0' + String(sec);

    // 如果分鐘為 1 的倍數，且秒數為 10
    // if (!Boolean(min % 1) && Boolean(sec == 10)) {
    // check(`now time is ${sh}:${sm}:${ss}`);
    // 如果分鐘為 10 的倍數，且秒數為 8
    if (!Boolean(min % 10) && Boolean(sec == 8)) {
        check('這裡填入要打的內容');
        console.log(`${sh}:${sm}:${ss}`);

    }
    // 如果分鐘為 1 的倍數，且秒數為 1 的倍數
    if (!Boolean(min % 1) && !Boolean(sec % 1)) {
        console.log(`${sh}:${sm}:${ss} checked`);
    }
}

// 每秒檢查一次
var timer = setInterval(check_time, 1 * 1000);


// 停止 timer
// clearInterval(timer);