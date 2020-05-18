library security_monkey_routing;

import 'package:angular/angular.dart';

void securityMonkeyRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'dashboard': ngRoute(
         path: '/dashboard',
         mount: {
           'view': ngRoute(
               path: '',
               view: 'views/dashboard.html'),
           'view_default': ngRoute(
               defaultRoute: true,
               view: 'views/error.html')
         }),
    'items': ngRoute(
        path: '/items/:regions/:technologies/:accounts/:accounttypes/:names/:arns/:active/:searchconfig/:min_score/:min_unjustified_score/:page/:count',
        defaultRoute: true,
        mount: {
          'view': ngRoute(
              path: '',
              view: 'views/searchpage.html'),
          'view_default': ngRoute(
              defaultRoute: true,
              view: 'views/error.html')
        }),
    'revisions': ngRoute(
        // Is this the best way to pass params?
        path: '/revisions/:regions/:technologies/:accounts/:accounttypes/:names/:arns/:active/:searchconfig/:page/:count',
        mount: {
          'view': ngRoute(
              path: '',
              view: 'views/searchpage.html'),
          'view_default': ngRoute(
              defaultRoute: true,
              view: 'views/error.html')
        }),
    'issues': ngRoute(
        // Is this the best way to pass params?
        path: '/issues/:regions/:technologies/:accounts/:accounttypes/:names/:arns/:active/:searchconfig/:page/:count',
        mount: {
          'view': ngRoute(
              path: '',
              view: 'views/searchpage.html'),
          'view_default': ngRoute(
              defaultRoute: true,
              view: 'views/error.html')
        }),
    'justified': ngRoute(
        path: '/justified/:regions/:technologies/:accounts/:accounttypes/:names/:arns/:active/:searchconfig/:page/:count',
        mount: {
          'view': ngRoute(
              path: '',
              view: 'views/searchpage.html'),
          'view_default': ngRoute(
              defaultRoute: true,
              view: 'views/error.html')
        }),
    'viewitemrevision': ngRoute(
        path: '/viewitem/:itemid/:revid',
        view: 'views/itemdetailsview.html'
        ),
    'viewitem': ngRoute(
        path: '/viewitem/:itemid',
        view: 'views/itemdetailsview.html',
        // Just an experiment to show how sub-routing works.
        // itemdetailsview.html has another <ng-view>
        // access at http://127.0.0.1:3030/SecurityMonkey/web/ui.html#/viewitem/6945/show
        // instead of just http://127.0.0.1:3030/SecurityMonkey/web/ui.html#/viewitem/6945
        mount: {
          'subroute': ngRoute(
            path: '/show',
            view: 'views/error.html'
          )
        }
        // END Experiment
        ),
    'signout': ngRoute(
            path: '/signout',
            view: 'views/signout.html'),
    'compare': ngRoute(
        path: '/compare',
        view: 'views/compare_item_revisions.html'),
    'settings': ngRoute(
                path: '/settings',
                view: 'views/settings.html'),
    'viewaccount': ngRoute(
            path: '/viewaccount/:accountid',
            view: 'views/account.html'),
    'createaccount': ngRoute(
                path: '/createaccount',
                view: 'views/create_account.html'),
    'viewwhitelist': ngRoute(
            path: '/viewwhitelist/:whitelistid',
            view: 'views/whitelist.html'),
    'createwhitelist': ngRoute(
                path: '/createwhitelist',
                view: 'views/create_whitelist.html'),
    'viewignoreentry': ngRoute(
            path: '/viewignoreentry/:ignoreentryid',
            view: 'views/ignoreentry.html'),
    'createignoreentry': ngRoute(
                path: '/createignoreentry',
                view: 'views/create_ignoreentry.html'),
    'createauditscore': ngRoute(
                path: '/createauditscore',
                view: 'views/create_auditscore.html'),
    'viewauditscore': ngRoute(
                path: '/viewauditscore/:auditscoreid',
                view: 'views/auditscore.html'),
    'createaccountpatternauditscore': ngRoute(
                path: '/auditscore/:auditscoreid/createaccountpatternauditscore',
                view: 'views/accountpatternauditscore.html'),
    'viewaccountpatternauditscore': ngRoute(
                path: '/auditscore/:auditscoreid/viewaccountpatternauditscore/:accountpatternauditscoreid',
                view: 'views/accountpatternauditscore.html')

  });

}

String URLNULL = "-";

// Reads a param from the URL with routeProvider.
// performs appropriate url decoding on parameter.
// Replaces null or empty params with URLNULL.
String param_from_url(String param_name, RouteProvider routeProvider, [String default_value = null]) {
    String param = routeProvider.parameters[param_name];
    if (param != null && param != URLNULL) {
        param = Uri.decodeComponent(param);
    } else {
        param = default_value;
    }
    return param;
}

// Prepares a param for placement in a URL.
// Replaces null or empty params with URLNULL.
// URL encodes param.
String param_to_url(String param) {
    if (param == null || param.isEmpty || param == "null") {
        param = URLNULL;
    }
    param = Uri.encodeComponent(param);
    return param;
}

Map<String, String> map_from_url(Map<String, String> expected_params, RouteProvider routeProvider) {
    Map<String, String> retval = new Map<String, String>();
    for (String key in expected_params.keys.toList()) {
        String value = param_from_url(key, routeProvider, expected_params[key]);
        retval[key] = value;
    }
    return retval;
}

Map<String, String> map_to_url(Map<String, String> expected_params) {
    Map<String, String> retval = new Map<String, String>();
    for (String key in expected_params.keys.toList()) {
        retval[key] = param_to_url(expected_params[key]);
    }
    return retval;
}
