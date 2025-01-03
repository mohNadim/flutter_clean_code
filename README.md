# clean_code_test

# وصف المشروع

**صف المشروع أنت** هو تطبيق مبتكر يهدف إلى تحسين تجربة المستخدم من خلال تقديم واجهة سهلة الاستخدام وميزات متقدمة. يعتمد التطبيق على تقنيات حديثة ويستفيد من أفضل الممارسات في تطوير البرمجيات.


## تطبيق مبادئ الكود النظيف

تم تطبيق مبادئ "الكود النظيف" في هذا المشروع من خلال:

- **التسمية الواضحة**: تم استخدام أسماء واضحة ودالة للمتغيرات، الدوال، والفئات مما يسهل فهم الكود.
- **تقسيم الكود**: تم تقسيم الكود إلى وحدات صغيرة ومتخصصة، مما يسهل الصيانة والاختبار.
- **التعليقات المفيدة**: تم إضافة تعليقات توضيحية في الأماكن الضرورية لشرح المنطق وراء الكود.
- **اختبارات شاملة**: تم تنفيذ اختبارات وحدات شاملة لضمان عمل كل جزء من الكود بشكل صحيح.
- **تجنب التكرار**: تم اتباع مبدأ DRY (Don't Repeat Yourself) لتقليل التكرار في الكود.

## استخدام مبادئ SOLID

تم تطبيق مبادئ SOLID في هذا المشروع لتعزيز جودة الكود وقابلية الصيانة. فيما يلي تفاصيل كيفية تطبيق كل مبدأ:

### 1. مبدأ المسؤولية الواحدة (Single Responsibility Principle - SRP)
كل فئة أو وحدة في المشروع لديها مسؤولية واحدة فقط. على سبيل المثال، فئة `PostRepository` مسؤولة فقط عن إدارة البيانات المتعلقة بالمنشورات، مما يسهل فهم الكود وصيانته.

### 2. مبدأ الانفتاح/الإغلاق (Open/Closed Principle - OCP)
تم تصميم الفئات بحيث تكون مفتوحة للإضافة ولكن مغلقة للتعديل. إذا كنت بحاجة إلى إضافة نوع جديد من المنشورات، يمكنك إنشاء فئة جديدة ترث من `Post` دون الحاجة إلى تعديل الكود الحالي.

### 3. مبدأ استبدال ليسكوف (Liskov Substitution Principle - LSP)
يمكن استخدام الكائنات من الفئات الفرعية في مكان الفئات الأساسية دون تغيير سلوك البرنامج. على سبيل المثال، فئة `ImagePost` يمكن أن تحل محل `Post` في أي مكان في الكود دون كسر الوظائف.

### 4. مبدأ فصل الواجهات (Interface Segregation Principle - ISP)
تم تصميم الواجهات بحيث تكون محددة ودقيقة، مما يمنع الفئات من تنفيذ واجهات لا تحتاجها. على سبيل المثال، واجهة `PostActions` تحتوي فقط على العمليات الضرورية للمنشورات، مثل `createPost` و`deletePost`.

### 5. مبدأ عكس الاعتماد (Dependency Inversion Principle - DIP)
يعتمد الكود على الواجهات بدلاً من الفئات المحددة. بدلاً من الاعتماد على فئة `PostRepository` مباشرة، يتم استخدام واجهة `IPostRepository`، مما يسهل استبدال التنفيذ أو استخدام Mocking أثناء الاختبار.

## خلاصة
تطبيق مبادئ SOLID يعزز من قابلية الصيانة والاختبار، مما يسهل إضافة ميزات جديدة وتحسين الكود دون التأثير على الأجزاء الأخرى من النظام.
