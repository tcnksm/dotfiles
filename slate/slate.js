
// relaunch slate
S.bind("r:alt", function(win) {
    S.operation("relaunch").run()
})

S.bind("return:alt", function(win) {
    S.shell("usr/bin/open -n -a iTerm")
})

S.bind('i:alt', function (win) {
    win.doOperation(S.operation('focus', { app: 'iTerm' }));
});

S.bind('c:alt', function (win) {
    win.doOperation(S.operation('focus', { app: 'Google Chrome' }));
});

