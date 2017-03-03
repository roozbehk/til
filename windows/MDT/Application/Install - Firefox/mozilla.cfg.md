
```
// OTC Mozilla Firefox Lockdown
// Disable updater
lockPref("app.update.enabled", false);
// Make absolutely sure it is really off
lockPref("app.update.auto", false);
lockPref("app.update.mode", 0);
lockPref("app.update.service.enabled", false);
// Disable Add-ons compatibility checking
clearPref("extensions.lastAppVersion"); 
// Don't show 'know your rights' on first run
pref("browser.rights.3.shown", true);
// Don't show WhatsNew on first run after every update
pref("browser.startup.homepage_override.mstone","ignore");
// Don't show Windows 10 splash screen on first run
pref("browser.usedOnWindows10", true);
// Set default homepage
lockPref("browser.startup.homepage","http://www.ucla.edu");
// Disable the internal PDF viewer
lockPref("pdfjs.disabled", true);
// Disable the flash to javascript converter
lockPref("shumway.disabled", true);
// Don't ask to install the Flash plugin
pref("plugins.notifyMissingFlash", false);
// Disable plugin checking
lockPref("plugins.hide_infobar_for_outdated_plugin", true);
clearPref("plugins.update.url");
// Disable health reporter
lockPref("datareporting.healthreport.service.enabled", false);
// Disable all data upload (Telemetry and FHR)
lockPref("datareporting.policy.dataSubmissionEnabled", false);
// Disable crash reporter
lockPref("toolkit.crashreporter.enabled", false);
Components.classes["@mozilla.org/toolkit/crash-reporter;1"].getService(Components.interfaces.nsICrashReporter).submitReports = false; 
// Disable default browser check
lockPref("browser.shell.checkDefaultBrowser", false);


// Enable Java Plugin
lockPref("security.enable_java", true);
// Automatically enable extensions
lockPref("extensions.autoDisableScopes", 0);
```
