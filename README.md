> **写在前面的话：项目copy下来后，直接用idea导入应该是没有问题的（项目的文件夹和包结构要正确），根据你的需要修改pom中的mysql驱动和数据库资源文件后就可以部署到tomcat运行了！**
## CRM客户管理系统（**spring + springMVC + mybatis**）
***
> **使用 SSM对原项目进行了升级**
1. **由于spring-mybatis和spring-tx已经保证了sqlsession的线程安全和事务处理，故取消了动态代理和事务回滚等相关的工具类，同时spring-mybatis已经使用动态代理和反射实现了Dao层，在业务中直接注入Dao层即可；**
2. **使用@ControllerAdvice的增强控制器类GlobalExceptionResolver能够捕获所有普通控制器的异常，并将相关异常信息按原请求路径返回；**      
3. **在业务层和控制层大量使用spring注解，简化开发的同时，极大地减少了代码的耦合和冗余,体现了spring的IOC和依赖注入思想；**        
4. **这里没有使用spring拦截器的原因是：spring拦截器只拦截@Controller注解的类，而不会去拦截jsp，因此spring提倡把jsp文件放到WEB-INF文件夹下，所以这里使用原版servlet过滤器；**          
5. **WebApplicationContextUtils可以非常方便的从servlet容器中取出spring容器；**      
6. **把一些不会重复创建的对象（有点单例的意思）的配置写在spring的配置文件中是典型的IOC思想, 当然也可以不用配置文件转而使用配置类；**     
7. **这里需要在mybatis的配置文件中进行相关配置后才能输出mybatis日志；**
8. **基于SSM的测试类也要进行相关配置，这与spring容器密不可分，好在有相关依赖支持这一配置，这种情况在spingboot里好很多，springboot几乎是一气呵成的；**
9. **虽然前端使用了JSTL和EL表达式甚至使用了java脚本，但仍是前后端不分离的项目，开发中会明显感觉到前端开发比后端费劲，这也是我们倡导前后端分离的原因之一，Vue与springbooot的结合能明显缓解这种差别；**
10. **总的来说，整个项目是一个非常好的项目，从深入MVC思想到前后端到数据库的一些细节都讲的很不错，遗憾的是没有涉及到spring-AOP的使用（因为项目总体不需要这个，如果硬要用可以自己做日志），虽然还有些公司还在用SSM，但当今spring的主流是springboot+各种中间件和应用层，现在学习SSM的主要好处就是能够了解部分spring的底层和思想，因为springMVC简化了servlet，springboot又简化springMVC，springboot功能的强大就是对底层的各种封装。好了不废话了，整个项目从搭环境到最后的Echarts差不多花了21天，每天平均差不多4个小时（日常琐事还有学新的东西的时间就不算进去了），SSM是去年跟着王鹤老师（挺不错一老师）学的，他的课件起了很大作用。整个项目中有很多问题都是后知后觉的，比如说控制层接收前端参数那里，有很多种接法，也是到最后我才知道“哦，还可以这么用...”。最后的最后，整个项目相当于三分之一原创项目吧，核心开发思想是老师的，我不过是用SSM和一些我的思想去完善他，由于是重在学习，项目中难免出现一些命名、路径等等的小问题，好在最后不影响大体的使用。好了，让我们在下一个springboot分布式项目再见吧！（以上所述，如果有些许不妥，欢迎各位斧正！）”**
> **注：做完“市场活动“模块的同学肯定会发现剩下的业务需要重写大量的增删改查非常麻烦，不写的话就是学老师一样往数据库里直接写数据（我觉得非常难受），所以我旨在针对核心业务的实现，把最能展现出核心业务实现过程的增删改查写了。因为需要部署到服务器供大家操作，所以我又删除了前端所有用不到的控件和页面，整个项目非常清爽，只留下来核心业务。**
***
> **[动力节点线下资料](http://www.bjpowernode.com/javavideo/124.html)**

> **[哔哩哔哩在线课程](https://www.bilibili.com/video/BV1fT4y1E7a6?from=search&seid=17945718129096207238)**
***
![示例图片](https://github.com/DragonLog/CRM/blob/main/pictureForExample/show1.jpg)
![示例图片](https://github.com/DragonLog/CRM/blob/main/pictureForExample/show2.jpg)
![示例图片](https://github.com/DragonLog/CRM/blob/main/pictureForExample/show3.jpg)
![示例图片](https://github.com/DragonLog/CRM/blob/main/pictureForExample/show4.jpg)
![示例图片](https://github.com/DragonLog/CRM/blob/main/pictureForExample/show5.jpg)