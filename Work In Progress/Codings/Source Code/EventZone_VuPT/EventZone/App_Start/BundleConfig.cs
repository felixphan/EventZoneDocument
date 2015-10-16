using System.Web;
using System.Web.Optimization;

namespace EventZone
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-1.11.3.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/unobstructive").Include(
                "~/Scripts/jquery.unobtrusive-ajax.js"));
            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.min.js",
                      "~/Scripts/respond.js"));
            bundles.Add(new ScriptBundle("~/bundles/datetime").Include(
            "~/Scripts/moment*",
            "~/Scripts/bootstrap-datetimepicker*"));
            bundles.Add(new ScriptBundle("~/bundles/barAndTab").Include(
                "~/Scripts/super-smooth.js",
                "~/Scripts/perfect-scrollbar.jquery.js",
                "~/Scripts/smooth-scrollspy.js"));
            bundles.Add(new ScriptBundle("~/bundles/myJS").Include(
                                      "~/Scripts/uikit.js",
                "~/Scripts//myJS_s_r.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/site.css",
                      "~/Content/uikit.css"));

            bundles.Add(new StyleBundle("~/Content/barAndTab").Include(
                "~/Content/perfect-scrollbar.css",
                "~/Content/bootstrap.vertical-tabs.css"));

            bundles.Add(new StyleBundle("~/Content/myCSS").Include(
                "~/Content/myCSS_chung.css",
                "~/Content/myCSS_s_r.css"));
        }
    }
}
