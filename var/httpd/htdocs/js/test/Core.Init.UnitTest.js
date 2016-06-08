// --
// Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var Core = Core || {};
Core.Init = Core.Init || {};

Core.Init = (function (Namespace) {
    Namespace.RunUnitTests = function(){
        module('Core.Init');

        test('Register and init namespaces', function () {
            Core.Init.Teststring = "";

            expect(3);

            Core.UnitTest1 = (function (TargetNS) {
                TargetNS.Init = function () {
                    Core.Init.Teststring += "1";
                };
                Core.Init.RegisterNamespace(TargetNS, 'APP_GLOBAL');
                return TargetNS;
            }(Core.UnitTest1 || {}));

            // testing sorting
            Core.UnitTest2 = (function (TargetNS) {
                TargetNS.Init = function () {
                    Core.Init.Teststring += "2";
                };
                Core.Init.RegisterNamespace(TargetNS, 'APP_GLOBAL');
                return TargetNS;
            }(Core.UnitTest2 || {}));

            Core.UnitTest3 = (function (TargetNS) {
                TargetNS.Init = function () {
                    Core.Init.Teststring += "3";
                };
                Core.Init.RegisterNamespace(TargetNS, 'APP_GLOBAL');
                return TargetNS;
            }(Core.UnitTest3 || {}));

            Core.UnitTest4 = (function (TargetNS) {
                TargetNS.Init = function () {
                    Core.Init.Teststring += "4";
                };
                Core.Init.RegisterNamespace(TargetNS, 'FINISH');
                return TargetNS;
            }(Core.UnitTest4 || {}));

            Core.UnitTest5 = (function (TargetNS) {
                TargetNS.Init = function () {
                    Core.Init.Teststring += "5";
                };
                Core.Init.RegisterNamespace(TargetNS, 'FINISH');
                return TargetNS;
            }(Core.UnitTest5 || {}));

            // empty call does nothing
            Core.Init.ExecuteInit();
            equal(Core.Init.Teststring, "");

            // calling first block
            Core.Init.ExecuteInit('APP_GLOBAL');
            equal(Core.Init.Teststring, "123");

            // calling second block
            Core.Init.ExecuteInit('FINISH');
            equal(Core.Init.Teststring, "12345");
        });
    };

    return Namespace;
}(Core.Init || {}));
