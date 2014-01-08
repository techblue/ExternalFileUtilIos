/*global cordova*/
'use strict';

var exec = cordova.require('cordova/exec'),
    win = function (success) {
        // do nothing, succeed quietly
    };

function openWith( path, uti, success, fail) {
    exec(success, fail, "ExternalFileUtilIos", "openWith", [path, uti]);
};

module.exports = {
    openWith: openWith
};
