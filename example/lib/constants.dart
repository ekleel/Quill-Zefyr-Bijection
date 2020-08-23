const QUILL_TO_ZEFYR_SAMPLE =
    "{\"ops\":[{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":\"It is a long \"},{\"attributes\":{\"background\":\"#ffffff\",\"bold\":true},\"insert\":\"established \"},{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":\"fact that a reader will \"},{\"attributes\":{\"background\":\"#ffffff\",\"italic\":true},\"insert\":\"be distracted \"},{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":\"by the readable content of a page when looking at its layout. The \"},{\"attributes\":{\"background\":\"#ffffff\",\"link\":\"fggh.com\"},\"insert\":\"point of using\"},{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":\" Lorem Ipsum is that it has a more-or-less normal distribution of letters, as oppo\"},{\"attributes\":{\"align\":\"justify\"},\"insert\":\"\\n\"},{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":\"sed to using 'Conten\"},{\"attributes\":{\"align\":\"justify\",\"header\":1},\"insert\":\"\\n\"},{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":\"t here, content here',\"},{\"attributes\":{\"align\":\"justify\",\"header\":2},\"insert\":\"\\n\"},{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":\" making it look like readable English. Many desktop publishing packages and web page editors now\"},{\"attributes\":{\"align\":\"justify\"},\"insert\":\"\\n\\n\"},{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":\" use Lorem Ipsum as their defa\"},{\"attributes\":{\"align\":\"justify\",\"blockquote\":true},\"insert\":\"\\n\"},{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":\"ult model text, and a search fo\"},{\"attributes\":{\"align\":\"justify\"},\"insert\":\"\\n\"},{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":\" 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evo\"},{\"attributes\":{\"align\":\"justify\"},\"insert\":\"\\n\"},{\"attributes\":{\"italic\":true,\"background\":\"#ffffff\",\"bold\":true},\"insert\":\"lved over the years, sometimes by a\"},{\"attributes\":{\"align\":\"justify\",\"header\":1},\"insert\":\"\\n\"},{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":\"ccident, sometimes on purpose (injected humour and the like).\"},{\"attributes\":{\"align\":\"justify\"},\"insert\":\"\\n\\n\"},{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":\"120 x 90 - Button 1\"},{\"insert\":\"\\n\"},{\"attributes\":{\"background\":\"#ffffff\"},\"insert\":{\"image\":\"https:\/\/www.lipsum.com\/images\/banners\/black_120x90.gif\"}},{\"attributes\":{\"align\":\"justify\"},\"insert\":\"\\n\\n\"},{\"insert\":\"\\n\"}]}";

/// Simple text
const QUILL_TO_ZEFYR_SIMPLE =
    '{\"ops\":[{\"insert\":\"قالتها يائسةً:  انا انتهيت !!! \\n\\\"لم يعد لي مكان هنا ، وقد وجب الرحيل \\\".\\n لم تكن كلماتها يوماً اكثر ثباتا من هذ المرة. بريق عينيها المنطفيء، كان دليلاً  كافياً ان امراً مريباً على وشك الحدوث.  تنبهت لذلك فور سقوط دمعة رقراقة من عينيها فما كان مني سوى ان أمسك بكلتا يديها بدفء محتضنة عينيها بكامل تركيزي لأقول  :\\nلااااا ، أؤكد لك انك لم تنتهي بعد يا صديقتي. \\nمازالت لقصتك بقية. و لست انت من ينهيها ، لست انت من يسدل الستار قبل اخر مشهد فيها، واهمة انت ان اعتقدت انه هكذا تختم القصص . عزيزتي عليك المحاولة مرة اخرى.\\n- عمياء انت الا تربن ان جميع محاولاتي نفذت. كل طاقاتي استنزفت. خساراتي المتتابعة لاتسمح لي باذلال كبريائي اكثر، وهاهو الخذلان الذي لازم رحلتي حتى من اقربهم يطعنني في كل خاطرة ذكرى او التفاتة حنين.\\n- لا لم تنفذ بدليل انك مازلت تعيشين الشتات ولم تجدين نفسك بعد وهذا يدعوك لمتابعة المسير حتى تجدينها  إياك ان تعتقدي اننا نعاكسك في ذلك فجميعنا في رحلة بحث ايضا  عن مكانه في هذا العالم . ولايغرنك من يعتقد ان مسقط رأسه هو الملاذ بل هو المنفى فلو كان الحال كذلك  فلماذا كل هذا البؤس على وجه امي وهي لم تغادر قريتها يوماً. كوني على يقين انك ستجدين ذاتك يوما وطول الرحلة ماهو الى مرحلة تجمعين فيها زوّادتك لذلك اليوم فلاتسمحي لليأس ان يتسلل الى نفسك ولاتمكني سخرية الاخرين من احلامك ولا لانتفاضتهم في كل مرة تحرزين تقدماً ان تثني عزيمتك. كما كانت بصيرتك قوية في الصبا وخطاك واضحة استمري و تناسي كل تلك التعقيدات التي حصلت حينها اطردي الخوف والقلق والشك من ذهنك، المهم ان تواصلي المسير، المواصلة هي الضمان الوحيد للنجاة في النهاية. هي البركة التي ستصاحب خطواتك صدقيني. فالاستسلام لعنة تصاحبها كل الخطايا لن أوهمك ان الحياة جميلة انا أؤكد لك انها جميلة بالفعل لاتحتاج منك سوى تأجيج شرارة الأمل باستمرار عاجلي حزنك بابتسامه باغتيه بفرح واكسري انهيارك برقصة.\\nلاتطبعي قصتك بحبر باهت و كئيب للعالم. اجعليه داكنا لماعًا . جميعنا مُلزَم ان يحكي حكايا نجاحه للناس فنحن رُسُل لبعضنا ولا قيمة بدون المجد. \\nحتى وان اندكت من حولك جميع أعمدة الأحلام فلتكوني  حجر الزاوية في صنع أخرى اكثر احكاماً. واجعلي من قصتك منفذا لأولئك الذين يبحثون عن ملاذا يحتويهم بعيداً عن قصصهم ويهروبون اليه من حكاياهم. بادري و اشعلي فتيلهم مرة اخرى .\\nسواء بقصة ، أو بأمل ، أو برجاء ، أو بعبور.\\n فان لم نكن مدينين لذواتنا ، فإننا حتماً مدينون للحياة. \\n\"}]}';

/// Complex Text Json
const QUILL_TO_ZEFYR_COMPLEX_JSON = {
  "ops": [
    {
      "attributes": {"bold": true},
      "insert": "المسجد النبوي"
    },
    {"insert": " أو الحرم النبوي أو مسجد النبي أحد أكبر المساجد في العالم وثاني أقدس موقع في الإسلام "},
    {
      "attributes": {"italic": true},
      "insert": "(بعد المسجد الحرام في مكة المكرمة)"
    },
    {
      "insert":
          "، وهو المسجد الذي بناه النبي محمد ﷺ في المدينة المنورة بعد هجرته سنة 1 هـ الموافق 622 بجانب بيته بعد بناء مسجد قباء. مرّ المسجد بعدّة توسعات عبر التاريخ، مروراً بعهد الخلفاء الراشدين والدولة الأموية فالعباسية والعثمانية، وأخيراً في عهد الدولة السعودية حيث تمت أكبر توسعة له عام 1994. ويعتبر المسجد النبوي أول مكان في شبه الجزيرة العربية يتم فيه الإضاءة عن طريق استخدام المصابيح الكهربائية عام 1327 هـ الموافق 1909.\nيقع المسجد في وسط المدينة المنورة، ويحيط به العديد من الفنادق والأسواق القديمة القريبة. "
    },
    {
      "attributes": {"bold": true},
      "insert": "وكثير من الناس"
    },
    {"insert": " الذين يؤدون فريضة الحج أو العمرة يقومون بزيارته، وزيارة قبر النبي محمد ﷺ للسلام عليه لحديث "},
    {
      "attributes": {"italic": true},
      "insert": "«من زار قبري وجبت له شفاعتي»"
    },
    {"insert": "."},
    {
      "attributes": {"blockquote": true},
      "insert": "\n"
    },
    {
      "insert": {
        "image": {"nid": "65mJ9ak@w#un(R6rh5ttDO-4)", "user": "9ukEt3oZUGUdzHz2JhElKKkGuw42"}
      }
    },
    {
      "insert": {"divider": true}
    },
    {"insert": "من فضائل المسجد النبوي"},
    {
      "attributes": {"h4": true},
      "insert": "\n"
    },
    {
      "insert":
          "ورد كثير من الأحاديث النبوية  تبيّن فضل المسجد النبوي، ومن ذلك:\nأنه أحد المساجد الثلاثة التي لا يجوز شدّ الرحال إلى مسجد إلا إليها."
    },
    {
      "attributes": {"list": "bullet"},
      "insert": "\n"
    },
    {"insert": "الصلاة فيه تعدل 1000 صلاة في غيره."},
    {
      "attributes": {"list": "bullet"},
      "insert": "\n"
    },
    {
      "insert":
          "فيه جزء يُسمى بـ \"الروضة المباركة\"، يقول فيها النبي محمد ﷺ: «ما بين بيتي ومنبري روضة من رياض الجنة، ومنبري على حوضي»."
    },
    {
      "attributes": {"list": "ordered"},
      "insert": "\n"
    },
    {
      "insert":
          "أنه من صلّى فيه 40 يوماً كُتبت له النجاة من النار، رُوي عن أنس بن مالك أن النبي محمد ﷺ قال: «من صلَّى في مسجدي أربعين صلاةً لا تفوته صلاةٌ كُتِبت له براءةٌ من النَّار وبراءةٌ من العذاب وبرِئ من النِّفاق». ولكنه يعتبر من الأحاديث الضعيفة."
    },
    {
      "attributes": {"list": "ordered"},
      "insert": "\n"
    },
    {
      "insert": {"divider": true}
    },
    {"insert": "في عهد الدولة السعودية"},
    {
      "attributes": {"h2": true},
      "insert": "\n"
    },
    {
      "insert": {"tweet": "1162004768367058944"}
    },
    {"insert": "التوسع��������������� ا��سعودية ا��أولى"},
    {
      "attributes": {"h4": true},
      "insert": "\n"
    },
    {
      "insert":
          "في 13 ربيع الأول من عام 1372 هـ الموافق 1952 بدأ العمل بتوسعة المسجد بأمر من الملك عبد العزيز آل سعود، وبعد أن قاموا بشراء الأراضي وهدمها لتهيئتها للبناء الجديد، بلغت مساحة المسجد الكلية 16326 متراً مربعاً تتسع إلى 28,000 مصلّ. وقد أقيم مصنعاً للحجر قرب المدينة لغايات الإعمار، وأما بقية المواد فكانت البواخر تحملها إلى ميناء ينبع ومن ثم إلى المدينة بواسطة سيارات كبيرة.\nالتوسعة السعودية الثانية"
    },
    {
      "attributes": {"h4": true},
      "insert": "\n"
    },
    {
      "insert":
          "في شهر محرم من عام 1406 هـ الموافق 1985، بدأ العمل بأكبر توسعة للمسجد النبوي بأمر من الملك فهد بن عبد العزيز آل سعود، وقد تم الانتهاء منها عام 1414 هـ الموافق 1994. وشملت التوسعة الجهات الشرقية والغربية والشمالية للمسجد، وذلك بإضافة مساحة 82,000 متراً مربعاً تستوعب حوالي 150,000 مصلّ، وبذلك أصبح المساحة الكلية للمسجد 98,326 متراً مربعاً تستوعب 178,000 مصلّ، ويُضاف مساحة السّطح 67,000 متراً مربعاً.\nالتوسعة السعودية الثالثة"
    },
    {
      "attributes": {"h4": true},
      "insert": "\n"
    },
    {"insert": "بأمر من "},
    {
      "attributes": {
        "link":
            "https://ar.wikipedia.org/wiki/%D8%B9%D8%A8%D8%AF_%D8%A7%D9%84%D9%84%D9%87_%D8%A8%D9%86_%D8%B9%D8%A8%D8%AF_%D8%A7%D9%84%D8%B9%D8%B2%D9%8A%D8%B2_%D8%A2%D9%84_%D8%B3%D8%B9%D9%88%D8%AF"
      },
      "insert": "الملك عبد الله بن عبد العزيز آل سعود"
    },
    {
      "insert":
          "، وفي شهر أغسطس 2010 تم الانتهاء من مشروع مظلات ساحات المسجد النبوي، وهو عبارة عن مظلات كهربائية على أعمدة الساحات المحيطة بالمسجد النبوي من الجهات الأربع، وتبلغ مساحتها 143 ألف متر مربع، بهدف وقاية المصلين من المطر وحرارة الشمس أثناء الصلاة. وشمل المشروع تصنيع وتركيب 182 مظلة على أعمدة ساحات المسجد النبوي، بالإضافة إلى 68 مظلة في الساحات الشرقية، ليصبح مجموع المظلات 250 مظلة. وبلغت تكلفته "
    },
    {
      "attributes": {"bold": true},
      "insert": "4.7 مليار ريال سعودي"
    },
    {"insert": ".\n"},
    {
      "insert": {"divider": true}
    },
    {
      "attributes": {"bold": true},
      "insert": "للمزيد من التفاصيل:"
    },
    {"insert": "\n"},
    {
      "insert": {"video": "https://www.youtube.com/embed/fxQJ6J517pM?showinfo=0"}
    },
    {"insert": "هذه القصة معاينة لمحرر \"كلمة\". المصدر: "},
    {
      "attributes": {"link": "https://ar.wikipedia.org/wiki/المسجد_��لنبوي"},
      "insert": "Wikipedia"
    },
    {
      "attributes": {"blockquote": true},
      "insert": "\n"
    }
  ],
};

/// Notus
const NOTUS_DOC_SAMPLE = [
  {'insert': 'Zefyr'},
  {
    'insert': '\n',
    'attributes': {'heading': 1}
  },
  {
    'insert': 'Soft and gentle rich text editing for Flutter applications.',
    'attributes': {'i': true}
  },
  {'insert': '\n'},
  {
    "insert": "​\n",
    "attributes": {
      "embed": {"type": "hr"}
    }
  },
  {
    'insert': '​',
    'attributes': {
      'embed': {'type': 'image', 'source': 'asset://assets/images/breeze.jpg'}
    }
  },
  {'insert': '\n'},
  {
    'insert': 'Photo by Hiroyuki Takeda.',
    'attributes': {'i': true}
  },
  {'insert': '\nZefyr is currently in '},
  {
    'insert': 'early preview',
    'attributes': {'b': true}
  },
  {'insert': '. If you have a feature request or found a bug, please file it at the '},
  {
    'insert': 'issue tracker',
    'attributes': {'a': 'https://github.com/memspace/zefyr/issues'}
  },
  {'insert': '.\nDocumentation'},
  {
    'insert': '\n',
    'attributes': {'heading': 3}
  },
  {
    'insert': 'Quick Start',
    'attributes': {'a': 'https://github.com/memspace/zefyr/blob/master/doc/quick_start.md'}
  },
  {
    'insert': '\n',
    'attributes': {'block': 'ul'}
  },
  {
    'insert': 'Data Format and Document Model',
    'attributes': {'a': 'https://github.com/memspace/zefyr/blob/master/doc/data_and_document.md'}
  },
  {
    'insert': '\n',
    'attributes': {'block': 'ul'}
  },
  {
    'insert': 'Style Attributes',
    'attributes': {'a': 'https://github.com/memspace/zefyr/blob/master/doc/attributes.md'}
  },
  {
    'insert': '\n',
    'attributes': {'block': 'ul'}
  },
  {
    'insert': 'Heuristic Rules',
    'attributes': {'a': 'https://github.com/memspace/zefyr/blob/master/doc/heuristics.md'}
  },
  {
    'insert': '\n',
    'attributes': {'block': 'ul'}
  },
  {
    'insert': 'FAQ',
    'attributes': {'a': 'https://github.com/memspace/zefyr/blob/master/doc/faq.md'}
  },
  {
    'insert': '\n',
    'attributes': {'block': 'ul'}
  },
  {'insert': 'Clean and modern look'},
  {
    'insert': '\n',
    'attributes': {'heading': 2}
  },
  {
    'insert':
        'Zefyr’s rich text editor is built with simplicity and flexibility in mind. It provides clean interface for distraction-free editing. Think Medium.com-like experience.\nMarkdown inspired semantics'
  },
  {
    'insert': '\n',
    'attributes': {'heading': 2}
  },
  {'insert': 'Ever needed to have a heading line inside of a quote block, like this:\nI’m a Markdown heading'},
  {
    'insert': '\n',
    'attributes': {'block': 'quote', 'heading': 3}
  },
  {'insert': 'And I’m a regular paragraph'},
  {
    'insert': '\n',
    'attributes': {'block': 'quote'}
  },
  {'insert': 'Code blocks'},
  {
    'insert': '\n',
    'attributes': {'heading': 2}
  },
  {'insert': 'Of course:\nimport ‘package:flutter/material.dart’;'},
  {
    'insert': '\n',
    'attributes': {'block': 'code'}
  },
  {'insert': 'import ‘package:zefyr/zefyr.dart’;'},
  {
    'insert': '\n\n',
    'attributes': {'block': 'code'}
  },
  {'insert': 'void main() {'},
  {
    'insert': '\n',
    'attributes': {'block': 'code'}
  },
  {'insert': ' runApp(MyZefyrApp());'},
  {
    'insert': '\n',
    'attributes': {'block': 'code'}
  },
  {'insert': '}'},
  {
    'insert': '\n',
    'attributes': {'block': 'code'}
  },
  {'insert': '\n\n\n'}
];

const QUILL_TO_ZEFYR_NOISSUE_JSON = {
  "ops": [
    {"insert": "السلام عليكم..\n"},
    {
      "insert": {"tweet": "1282747519626350592"}
    },
    {"insert": "مرحباً\nأهلًا..\n"},
    {
      "insert": {"video": "https://www.youtube.com/embed/bczyP-kDwSA"}
    },
    {
      "insert": {"video": "https://www.youtube.com/embed/bczyP-kDwSA"}
    },
    {"insert": "رائع جدا!"},
    {
      "insert": {"divider": true}
    },
    {
      "insert": {"tweet": "1282747893447823361"}
    },
    {
      "insert": {"video": "https://www.youtube.com/embed/8ElKxTfHdWo"}
    },
    {"insert": "شكرا لك\n"}
  ]
};
