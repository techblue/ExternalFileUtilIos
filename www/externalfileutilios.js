/*global cordova*/
'use strict';

var exec = cordova.require('cordova/exec'),
    win = function (success) {
        // do nothing, succeed quietly
    };

function openWith( path, uti, success, fail) {
    return cordova.exec(success, fail, "ExternalFileUtil", "openWith", [path, uti]);
};

module.exports = {
    openWith: openWith
};
