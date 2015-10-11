using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(EventZone.Startup))]
namespace EventZone
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
