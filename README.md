# 🏢 Human Resources Management System Database (HR_DATABASE_DB)

[English](#english-version) | [العربية](#النسخة-العربية)

---

## النسخة العربية

### 📝 وصف المشروع
مشروع **قاعدة بيانات إدارة الموارد البشرية المتكاملة** هو نظام مصمم لإدارة رأس المال البشري بكفاءة وتوسعية عالية باستخدام **SQL Server (SSMS)**. تم بناء النظام بالاعتماد على معايير هندسة البيانات المتقدمة لضمان أمن البيانات، تكاملها، وحوكمتها عبر فصل المهام والوظائف الأساسية.

### 📐 الهندسة المعمارية وقسم المخططات (Schema Design)
تم تقسيم النظام إلى **4 مخططات رئيسية (Schemas)** تحتوي على **11 جدولاً منظماً** مترابطة بشكل وثيق حول الجدول المركزي للموظفين لضمان تقليل التكرار (Normalization):

1. **مخطط النواة (Core Schema):**
   * يحتوي على البيانات الأساسية للموظفين، الهيكل التنظيمي للأقسام، والمسميات الوظيفية.
   * *الجداول:* `COR_employees` (الجدول الأساسي)، `COR_departments`، `COR_positions`.
2. **مخطط الأجور والرواتب (Payroll Schema):**
   * يعنى بإدارة المستحقات المالية، الرواتب الأساسية، البدلات، والتعديلات المالية مع تطبيق معايير التشفير للحماية.
   * *الجداول:* جداول مسؤولة عن مسيرات الرواتب والمراقبة مثل `PRL_payroll` و `PRL_payroll_audit`.
3. **مخطط الحضور والغياب (Attendance Schema):**
   * يراقب سجلات الدخول والخروج اليومية، طلبات الإجازات، والأرصدة المستحقة لكل موظف.
   * *الجداول:* جداول التحضير والإجازات مثل `ATT_vacations`.
4. **مخطط الاستقطاب والتوظيف (Recruitment Schema):**
   * يغطي حراج الكفاءات بدءاً من المتقدمين للوظائف، المقابلات الشخصية، وحتى اتخاذ قرار التعيين.

### 🔒 الحوكمة والأمن الرقمي
* **إدارة الصلاحيات (DBA Role):** تم عزل سكريبت التأسيس الرئيسي والـ Passwords الحقيقية محلياً عن طريق قواعد Git الصارمة، وإتاحة ملف تمبلت آمن للعرض يعتمد على دور `db_owner` لحساب إدارة النظام `DBA_Admin`.
* **سرية البيانات:** عزل جداول الرواتب الحساسة برمجياً تمهيداً لتطبيق التشفير الشامل للبيانات المالية الحساسة.
## 🗄️ بنية وهندسة قاعدة البيانات (Database Architecture)

تم تصميم قاعدة بيانات النظام استناداً إلى مفهوم **المخططات المجزأة (Sub-schemas/Modules)** لضمان كفاءة الأداء، عزل الصلاحيات، وسهولة التوسع المستقبلي. ينقسم النظام إلى **4 مخططات رئيسية** موزعة كالتالي:

### 1. 👥 مخطط البيانات الأساسية | Core Schema (`COR`)
يمثل النواة المركزية للنظام ويحتوي على البيانات الهيكلية للمنظمة وعلاقات الموظفين الأساسية (**3 جداول**):
* **`COR_departments`** ── (الأقسام) إدارة الهيكل الإداري، القطاعات، والفروع داخل المنشأة.
* **`COR_employees`** ── (الموظفين) الملفات التعريفية للموظفين، البيانات الشخصية، وحالات التعيين.
* **`COR_positions`** ── (الوظائف والمراتب) المسميات الوظيفية، التوصيف الوظيفي، والدرجات/السلالم الوظيفية.

### 2. 💰 مخطط الرواتب والمالية | Payroll Schema (`PRL`)
يختص بكافة العمليات الحسابية، التعويضات، والالتزامات المالية الخاصة بالموارد البشرية (**4 جداول**):
* **`PRL_payroll`** ── (مسيرات الرواتب) احتساب الرواتب الأساسية، البدلات، الاستقطاعات الضريبية، وصافي المستحقات.
* **`PRL_bonus`** ── (المكافآت) إدارة الحوافز والمكافآت الدورية مع تتبع حالات الاعتماد والصرف الدقيق.
* **`PRL_loans`** ── (القروض والأقساط) تنظيم السلف والقروض الشخصية وجدولة الاستقطاعات الشهرية المؤتمتة.
* **`PRL_overtime`** ── (العمل الإضافي) رصد وتدقيق ساعات العمل الإضافية واحتساب التعويض المالي المقابل لها.

### 3. 📅 مخطط إدارة الحضور والإجازات | Attendance Schema (`ATT`)
يتحكم في تتبع انضباط القوى العاملة وإدارة الإجازات الرسمية والخاصة (**جدولين**):
* **`ATT_vacations`** ── (الإجازات) إدارة طلبات الإجازات بمختلف أنواعها، وتتبع الأرصدة المستحقة والمستهلكة.
* **`ATT_attendance`** ── (سجلات الحضور) السجلات اليومية لعمليات الحضور، الانصراف، التأخير، والغياب بشكل دقيق.

### 4. 🤝 مخطط الاستقطاب والتوظيف | Recruitment Schema (`REC`)
يغطي الدورة الكاملة لجلب الكفاءات وتصفية المتقدمين الجدد للنظام (**جدولين**):
* **`REC_job_postings`** ── (الوظائف الشاغرة) إدارة وتتبع الفرص الوظيفية المعلنة ومواصفات كل شاغر وظيفي.
* **`REC_applicants`** ── (المتقدمين للوظائف) قاعدة بيانات المتقدمين، تتبع مراحل المقابلات، وأنظمة الفرز والتصفية الأولي.

---

## English Version

### 📝 Project Overview
The **HR Management System Database** is an enterprise-grade relational database architecture engineered utilizing **SQL Server (SSMS)**. The system is meticulously designed to optimize human capital operations, reinforce data integrity, and ensure strict data governance through separation of concerns.

### 📐 Database Architecture & Schema Layout
The database features **4 modular schemas** governing **11 interrelated tables**, structured around a central employee entity to achieve optimal normalization and scalability:

1. **Core Schema:**
   * Manages enterprise foundation data including central identity records, corporate departments, and organizational roles.
   * *Key Entities:* `COR_employees` (Central Master Table), `COR_departments`, `COR_positions`.
2. **Payroll Schema:**
   * Controls financial ledger records, basic salaries, benefits, allowances, and compensation tracking with encryption readiness.
   * *Key Entities:* Financial tracking and auditing modules such as `PRL_payroll` and `PRL_payroll_audit`.
3. **Attendance Schema:**
   * Monitors daily logs, timesheets, vacation cycles, and statutory time-off balances.
   * *Key Entities:* Time-tracking tables such as `ATT_vacations`.
4. **Recruitment Schema:**
   * Tracks target talent pipelines from applicants and interview staging up to hiring decisions.

### 🔒 Governance & Security Strategy
* **Privilege Management (DBA Role):** Implemented a rigorous security baseline using localized Git environment isolation. Server logins and database users (`DBA_Admin_User`) are mapped to the `db_owner` role using secure templates.
* **Data Privacy:** Strategic physical and logical isolation of financial elements to prepare for granular column-level data encryption.


## 🗄️ Database Architecture & Schema Design

The database is architected using a modular **Multi-Schema approach** to ensure high performance, strict data isolation, role-based access control, and seamless scalability. The system is split into **4 core domains**:

### 1. 👥 Core Schema (`COR`)
Serves as the backbone of the application, managing structural organization and employee profiles (**3 Tables**):
* **`COR_departments`** ── Manages organizational hierarchy, divisions, and company branches.
* **`COR_employees`** ── Stores master employee profiles, personal records, and employment statuses.
* **`COR_positions`** ── Defines job titles, role descriptions, salary grades, and ranks.

### 2. 💰 Payroll Schema (`PRL`)
Handles all financial computations, compensations, and monetary liabilities (**4 Tables**):
* **`PRL_payroll`** ── Computes base salaries, allowances, tax deductions, and net payouts.
* **`PRL_bonus`** ── Tracks performance bonuses, incentives, and approval workflows.
* **`PRL_loans`** ── Manages employee advances, loans, and automated monthly installment scheduling.
* **`PRL_overtime`** ── Logs extra working hours and calculates respective monetary compensations.

### 3. 📅 Attendance Schema (`ATT`)
Tracks workforce time management, daily discipline, and time-off requests (**2 Tables**):
* **`ATT_vacations`** ── Manages leave requests (annual, medical, casual) and tracks time-off balances.
* **`ATT_attendance`** ── Records precise daily clock-in/out timestamps, delays, and absences.

### 4. 🤝 Recruitment Schema (`REC`)
Facilitates the talent acquisition lifecycle and applicant tracking workflows (**2 Tables**):
* **`REC_job_postings`** ── Publishes and manages active job openings, requirements, and vacancies.
* **`REC_applicants`** ── Stores candidate profiles, tracks interview stages, and manages screening filters.


### 5.   HR Entity Relationship Diagram (ERD) 

![HR Entity Relationship Diagram](ERD_HR_DATABASE_DB.png)
