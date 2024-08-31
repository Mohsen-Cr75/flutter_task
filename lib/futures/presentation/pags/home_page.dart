import 'package:flutter/material.dart';
import 'package:flutter_task/futures/presentation/pags/users_page.dart';
import '../../../widgets/custom_textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //ساخت لیست فوکوس نود برای یک لیست چهارتایی
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  //ساخت لیست تکست کنترلر برای یک لیست چهارتایی
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  /*
  ما نیاز داریم تا ورودی های تکست فیلد را عضوی از یک
   لیست در نظر بگیریم تا بتوانیم انخاب های بهتر و بیشتز و آسان تری داشته باشیم
  */
  List digit = [
    [],
    [],
    [],
    [],
  ];
  //  جهت نحوه نمایش ورودی ها در تکست فیلد
  bool password = false;
  //  بقدار ایت متغیر تعیین میکند که آیا باید وجود یک خطا را اعلان بکنیم
  bool onError = false;


  // لازم است متغییر های وارد شده را به عنوان یک عضو واحد مورد بررسی قرار دهیم پس آنها را با هم ادغام میکنیم
  // ادغام : تنها ورودی ها را به هم میچسانیم بدون هیچ عملیات دیگری
  int? checkEntry() {
    String result = digit
        .map((sublist) => sublist.isNotEmpty ? sublist[0].toString() : '')
        .join();

    // ممکن است ورودی تهی باشد
    if (result.isEmpty) {
      return 0;
    }
    return int.parse(result);
  }

  // به تغییرات ورودی در تکست فیلد واکنش نشان مبدهد
  void _onChange(String value, int i)
  {setState(() {
      // اگر برنامه در حال تشان دادن خظایی باشد با بودن در این جا
      // متوجه میشویم کاربر در حال اددیت ورودی است پس نشان
      // دادن ارور را لغو میکنیم
      onError = false;
    });

    //اگر  اولین وردی بود سریعا به اولین عنصر لست اضافه شود
    if (digit[i].isEmpty) {
      digit[i].add(value[0]);
    }

    String newText = value; // داده دریافتی را به عنوان یک متغییر داخلی ثبت و استفاد ه میکنیم
//و اگر متغییر null  نبود عملیاتی را برای انتحاب و جایگذاری بهترین متغییر در تکست فیلد شروع میکنیم
    if (value.isNotEmpty) {
      // اگر تکست فیلد مقدار دهی شده بود مقدار قبلی حذف و مقدار جدید جایگزین شود
      if (value.length == 1) {
        digit[i].clear();
        digit[i].add(value[0]);
      } else if (value.length >= 2) {
        // ما تکست فیلد ها را با امکان ورود 2 متغییر تعریف کرده ایم تا انتخاب های بیشتری داشته باشیم
        // و متغییر اول را value1 و بعدی را value2 می نامیم
        String value1 = value[0];
        String value2 = value[1];
        // وقتی تکست فیلد مقدار دارد و کاربر یک مقدار دیگری را بدون پاک کردن مقدار قبلی وارد میکند
        // روند انتخابی اینگونه خواهد بود
        // اگر دومین (یکان) متغییر برابر با متغیر قبلی باشد و اولی نباشد و چون داده بدون
        // پاک شدن نوشته شده است پس متغییر دومی همان متغییر قبلی و متغییر جدید متغییر اولی است
        if (digit[i][0] == value2 && digit[i][0] != value1) {
          newText = value1;
          digit[i][0] = value1;
          // اگر اولین (دهگان) متغییر برابر با متغیر قبلی باشد و دومی نباشد و چون داده بدون
          // پاک شدن نوشته شده است پس متغییر اولی همان متغییر جدید و متغییر دومی متغییر قبلی است
          //این حالت زمانی رخ میدهد که کاربر نشانگر متنی را قبل از متغییر قبلی قرار دهد که در این صورت
          //   backSpace
          // هم کار نمیکند پس با یک مقاسه کوچک این مورد را نیز رفع  میکنیم

        } else if (digit[i][0] != value2 && digit[i][0] == value1) {

          newText = value2;
          digit[i][0] = value2;
        // ممکن است ورودی تکراری باشد پس متغییر قبلی با هر دو برابر است
        } else if (digit[i][0] == value2 && digit[i][0] == value1) {
          newText = value2;
          digit[i][0] = value2;
        }
      }
    } else {
      //وفتی کاربر تمام کاراکتر های یک تست فیلد را پاک کرده است
      digit[i].clear();
    }

    // اگر تکست فیلد مقدار دارد و هنوز به آخرین تکست فیلد نرسیده ایم
    //برو به تکست فیلد بعدی
    if (value.isNotEmpty && i < 3) {
      FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
    // مقدار تکست فیلد را پاک کرده ایم و در اولین تسکت فیلد نسیتیم
    //   پس برگرد به تکست فیلد قبلی
    } else if (value.isEmpty && i > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
     //اگر همه تکست فیلد ها مقدار دهی شده اند کیبورد را ببند
    } else if (value.isNotEmpty && i >= 3) {
      FocusScope.of(context).unfocus();
    }


    _controllers[i].text = newText; // مقدار کنترلر را بعد از هر بار عملیات به صورت دستی کنترل مبکنیم


    // نشانگر موس که در بالا گفته بودم ممکن است در جای درستش نباشد اینگونه بعد از عملیات
    // در جای خودش قرار می دهیم
    _controllers[i].selection =
        TextSelection.fromPosition(TextPosition(offset: newText.length));

  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entry Page')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Enter your code to go next page '),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i <= 3; i++)
                    SizedBox(
                      width: 50,
                      child: AnimatedTextField(
                        controller: _controllers[i],
                        focusNode: _focusNodes[i],
                        onchange: (value) => _onChange(value, i),
                        password: password,
                        onError: onError,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              if (onError)
                const Text(
                  "Fill all the box's",
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  //به وسیله این چک باکس مشخص بکنید که آیا تکست فیلد شما
                  // ورودی را به صورت کد دریافت میکند یا پسورد
                  Checkbox(
                    value: password,
                    onChanged: (value) {
                      setState(() {
                        password = !password;
                      });
                    },
                  ),
                  const Text('Password mode'),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  int number = checkEntry() ?? 0;
                  // بررسی میکنیم آیا مقدار ورودی ها درست است یا که خیر
                  // اگر نبود عملیاتی را جهت نشان دادن وجود ارور انجام میدهیم
                  if (number.toString().padLeft(4, '0').length < 4) {
                    setState(() {
                      onError = true;
                    });
                  }
                  // اگر بود به صفحه بعدی میرویم
                  // رشته با حداقل طول 4 و صفرهای اولیه
                  // چون د راین حالت ممکن است 0 های اول را درنظر نگید
                  if(number.toString().padLeft(4, '0').length == 4){
                    Navigator.of(context).push( MaterialPageRoute(builder: (context) => UsersDataPage(),) );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    'Check',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
