using Microsoft.Practices.Unity;
using TextbookSubscription.Infrastructure.ServiceLocators;
using TextbookSubscription.Infrastructure.Cache;
using TextbookSubscription.Application.DTOAdapter;
using TextbookSubscription.Infrastructure.Logger;
using TextbookSubscription.Infrastructure;
using Microsoft.Practices.Unity.InterceptionExtension;
using TextbookSubscription.Domain.IRepositories;
using TextbookSubscription.Repository;
using TextbookSubscription.IApplication;
using TextbookSubscription.Application;
using TextbookSubscription.Infrastructure.InterceptionBehaviors;
using TextbookSubscription.Domain;

namespace TextbookManage.WebUI
{
    public class UnityBootstrapper : IUnityBootstrapper
    {
        public void RegisterTypes(IUnityContainer container)
        {
            //Register Interceptor
            container.AddNewExtension<Interception>();
            //Infrastructure
            container
                //类型适配器
                .RegisterType<ITypeAdapter, AutoMapperTypeAdapter>()
                //缓存
                .RegisterType<ICacheProvider, EntLibCacheProvider>(new ContainerControlledLifetimeManager())
                //异常记录器
                .RegisterType<ILogger, Log4netLogger>(LoggerName.ExceptionLogger.ToString(), new InjectionConstructor(LoggerName.ExceptionLogger.ToString()))
                //日志记录器
                .RegisterType<ILogger, Log4netLogger>(LoggerName.Logger.ToString(), new InjectionConstructor(LoggerName.Logger.ToString()));
            //DbContext
            container.RegisterType<IRepositoryDbContext, EFRepositoryDbContext>(new PerResolveLifetimeManager());
            //Repository
            container
                .RegisterType<ITermRepository, TermRepository>();
            //Application
            container
                .RegisterType<ITermAppl, TermAppl>(
                new Interceptor<InterfaceInterceptor>(),
                new InterceptionBehavior<CacheBehavior>(),
                new InterceptionBehavior<ExceptionLoggerBehavior>()
                );
        }
    }
}