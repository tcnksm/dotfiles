
// relaunch slate
S.bind("r:alt", function(win) {
    S.operation("relaunch").run()
})

var launch_and_focus = function (target) {
    return function (win) {
        var apps = [];
        S.eachApp(function (app) { apps.push(app.name()); });
        if (! _.find(apps, function (name) { return name === target; })) {
            win.doOperation(
                S.operation('shell', {
                    command: "/usr/bin/open -a " + target,
                    waithFoeExit: true
                })
            );
        }
        win.doOperation(S.operation('focus', { app: target }));
    };
};


S.bind('i:alt', launch_and_focus('iTerm'));
S.bind('c:alt', launch_and_focus('Google Chrome'));


