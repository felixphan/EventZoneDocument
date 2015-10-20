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
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/respond.js"));
            bundles.Add(new ScriptBundle("~/bundles/datetime").Include(
            "~/Scripts/moment*",
            "~/Scripts/bootstrap-datetimepicker*"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/site.css"));
            //bundles.Add(new ScriptBundle("~/bundles/myScript").Include(
            //          "~/Scripts/jquery-1.11.3.min.js" , 
            //          "~/Scripts/super-smooth.js"
            //    ));
            //bundles.Add(new ScriptBundle("~/bundles/myScript1").Include(
            //          "~/Scripts/perfect-scrollbar.jquery.js",
            //          "~/Scripts/myJS_u_w_e.js"
            //    ));
            //bundles.Add(new ScriptBundle("~/bundles/myCss").Include(
            //         "~/Content/perfect-scrollbar.css",
            //         "~/Content/myCSS_chung.css"
            //   ));
            //bundles.Add(new ScriptBundle("~/bundles/myCss1").Include(
            //         "~/Content/myCSS_u_w_e.css"
            //   ));
            

        }
    }
}
