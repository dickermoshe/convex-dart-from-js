// ignore_for_file: type=lint, unused_import, unnecessary_question_mark, dead_code
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_raw_type, inference_failure_on_untyped_parameter, invalid_use_of_internal_member
import "package:convex_dart/src/convex_dart_for_generated_code.dart";

enum $blue$red {
  $blueMember($blue()),
  $redMember($red());

  const $blue$red(this.value);
  final Literal value;
  static final _map = {'blue': $blueMember, 'red': $redMember};
  static $blue$red fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $blue$red;
    }
    throw Exception(value.toString() + r" cannot be converted to a $blue$red");
  }
}

enum $yes$no {
  $yesMember($yes()),
  $noMember($no());

  const $yes$no(this.value);
  final Literal value;
  static final _map = {'yes': $yesMember, 'no': $noMember};
  static $yes$no fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $yes$no;
    }
    throw Exception(value.toString() + r" cannot be converted to a $yes$no");
  }
}

enum $10$20$30 {
  $1_0Member($1_0()),
  $2_0Member($2_0()),
  $3_0Member($3_0());

  const $10$20$30(this.value);
  final Literal value;
  static final _map = {1.0: $1_0Member, 2.0: $2_0Member, 3.0: $3_0Member};
  static $10$20$30 fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $10$20$30;
    }
    throw Exception(value.toString() + r" cannot be converted to a $10$20$30");
  }
}

enum $admin$user$guest {
  $adminMember($admin()),
  $userMember($user()),
  $guestMember($guest());

  const $admin$user$guest(this.value);
  final Literal value;
  static final _map = {
    'admin': $adminMember,
    'user': $userMember,
    'guest': $guestMember,
  };
  static $admin$user$guest fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $admin$user$guest;
    }
    throw Exception(
      value.toString() + r" cannot be converted to a $admin$user$guest",
    );
  }
}

enum $true$false {
  $trueMember($true()),
  $falseMember($false());

  const $true$false(this.value);
  final Literal value;
  static final _map = {true: $trueMember, false: $falseMember};
  static $true$false fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $true$false;
    }
    throw Exception(
      value.toString() + r" cannot be converted to a $true$false",
    );
  }
}

enum $work$personal$urgent {
  $workMember($work()),
  $personalMember($personal()),
  $urgentMember($urgent());

  const $work$personal$urgent(this.value);
  final Literal value;
  static final _map = {
    'work': $workMember,
    'personal': $personalMember,
    'urgent': $urgentMember,
  };
  static $work$personal$urgent fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $work$personal$urgent;
    }
    throw Exception(
      value.toString() + r" cannot be converted to a $work$personal$urgent",
    );
  }
}

enum $text$number$boolean {
  $textMember($text()),
  $numberMember($number()),
  $booleanMember($boolean());

  const $text$number$boolean(this.value);
  final Literal value;
  static final _map = {
    'text': $textMember,
    'number': $numberMember,
    'boolean': $booleanMember,
  };
  static $text$number$boolean fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $text$number$boolean;
    }
    throw Exception(
      value.toString() + r" cannot be converted to a $text$number$boolean",
    );
  }
}

enum $pending$approved$rejected {
  $pendingMember($pending()),
  $approvedMember($approved()),
  $rejectedMember($rejected());

  const $pending$approved$rejected(this.value);
  final Literal value;
  static final _map = {
    'pending': $pendingMember,
    'approved': $approvedMember,
    'rejected': $rejectedMember,
  };
  static $pending$approved$rejected fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $pending$approved$rejected;
    }
    throw Exception(
      value.toString() +
          r" cannot be converted to a $pending$approved$rejected",
    );
  }
}

enum $string$number$boolean {
  $stringMember($string()),
  $numberMember($number()),
  $booleanMember($boolean());

  const $string$number$boolean(this.value);
  final Literal value;
  static final _map = {
    'string': $stringMember,
    'number': $numberMember,
    'boolean': $booleanMember,
  };
  static $string$number$boolean fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $string$number$boolean;
    }
    throw Exception(
      value.toString() + r" cannot be converted to a $string$number$boolean",
    );
  }
}

enum $primitive$object$array {
  $primitiveMember($primitive()),
  $objectMember($object()),
  $arrayMember($array());

  const $primitive$object$array(this.value);
  final Literal value;
  static final _map = {
    'primitive': $primitiveMember,
    'object': $objectMember,
    'array': $arrayMember,
  };
  static $primitive$object$array fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $primitive$object$array;
    }
    throw Exception(
      value.toString() + r" cannot be converted to a $primitive$object$array",
    );
  }
}

enum $red$blue$green {
  $redMember($red()),
  $blueMember($blue()),
  $greenMember($green());

  const $red$blue$green(this.value);
  final Literal value;
  static final _map = {
    'red': $redMember,
    'blue': $blueMember,
    'green': $greenMember,
  };
  static $red$blue$green fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $red$blue$green;
    }
    throw Exception(
      value.toString() + r" cannot be converted to a $red$blue$green",
    );
  }
}

enum $get$post$put$delete {
  $GETMember($GET()),
  $POSTMember($POST()),
  $PUTMember($PUT()),
  $DELETEMember($DELETE());

  const $get$post$put$delete(this.value);
  final Literal value;
  static final _map = {
    'GET': $GETMember,
    'POST': $POSTMember,
    'PUT': $PUTMember,
    'DELETE': $DELETEMember,
  };
  static $get$post$put$delete fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $get$post$put$delete;
    }
    throw Exception(
      value.toString() + r" cannot be converted to a $get$post$put$delete",
    );
  }
}

enum $minute$hour$day {
  $minuteMember($minute()),
  $hourMember($hour()),
  $dayMember($day());

  const $minute$hour$day(this.value);
  final Literal value;
  static final _map = {
    'minute': $minuteMember,
    'hour': $hourMember,
    'day': $dayMember,
  };
  static $minute$hour$day fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $minute$hour$day;
    }
    throw Exception(
      value.toString() + r" cannot be converted to a $minute$hour$day",
    );
  }
}

enum $string$number$boolean$date {
  $stringMember($string()),
  $numberMember($number()),
  $booleanMember($boolean()),
  $dateMember($date());

  const $string$number$boolean$date(this.value);
  final Literal value;
  static final _map = {
    'string': $stringMember,
    'number': $numberMember,
    'boolean': $booleanMember,
    'date': $dateMember,
  };
  static $string$number$boolean$date fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $string$number$boolean$date;
    }
    throw Exception(
      value.toString() +
          r" cannot be converted to a $string$number$boolean$date",
    );
  }
}

enum $action$condition$loop {
  $actionMember($action()),
  $conditionMember($condition()),
  $loopMember($loop());

  const $action$condition$loop(this.value);
  final Literal value;
  static final _map = {
    'action': $actionMember,
    'condition': $conditionMember,
    'loop': $loopMember,
  };
  static $action$condition$loop fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $action$condition$loop;
    }
    throw Exception(
      value.toString() + r" cannot be converted to a $action$condition$loop",
    );
  }
}

enum $10$20 {
  $1_0Member($1_0()),
  $2_0Member($2_0());

  const $10$20(this.value);
  final Literal value;
  static final _map = {1.0: $1_0Member, 2.0: $2_0Member};
  static $10$20 fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $10$20;
    }
    throw Exception(value.toString() + r" cannot be converted to a $10$20");
  }
}

enum $read$write$admin {
  $readMember($read()),
  $writeMember($write()),
  $adminMember($admin());

  const $read$write$admin(this.value);
  final Literal value;
  static final _map = {
    'read': $readMember,
    'write': $writeMember,
    'admin': $adminMember,
  };
  static $read$write$admin fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $read$write$admin;
    }
    throw Exception(
      value.toString() + r" cannot be converted to a $read$write$admin",
    );
  }
}

enum $a$b$c {
  $AMember($A()),
  $BMember($B()),
  $CMember($C());

  const $a$b$c(this.value);
  final Literal value;
  static final _map = {'A': $AMember, 'B': $BMember, 'C': $CMember};
  static $a$b$c fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $a$b$c;
    }
    throw Exception(value.toString() + r" cannot be converted to a $a$b$c");
  }
}

enum $on$off {
  $onMember($on()),
  $offMember($off());

  const $on$off(this.value);
  final Literal value;
  static final _map = {'on': $onMember, 'off': $offMember};
  static $on$off fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $on$off;
    }
    throw Exception(value.toString() + r" cannot be converted to a $on$off");
  }
}

enum $cat$dog {
  $catMember($cat()),
  $dogMember($dog());

  const $cat$dog(this.value);
  final Literal value;
  static final _map = {'cat': $catMember, 'dog': $dogMember};
  static $cat$dog fromValue(Object value) {
    if (_map.containsKey(value)) {
      return _map[value] as $cat$dog;
    }
    throw Exception(value.toString() + r" cannot be converted to a $cat$dog");
  }
}

class $hi implements Literal {
  const $hi();
  const $hi.validate(dynamic value)
    : assert(value == 'hi', r"Value mismatch for $hi");

  @override
  final value = 'hi';

  @override
  bool operator ==(Object other) {
    if (other is $hi) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$hi(hi)";
  }
}

class $1_0 implements Literal {
  const $1_0();
  const $1_0.validate(dynamic value)
    : assert(value == 1.0, r"Value mismatch for $1_0");

  @override
  final value = 1.0;

  @override
  bool operator ==(Object other) {
    if (other is $1_0) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$1_0(1)";
  }
}

class $true implements Literal {
  const $true();
  const $true.validate(dynamic value)
    : assert(value == true, r"Value mismatch for $true");

  @override
  final value = true;

  @override
  bool operator ==(Object other) {
    if (other is $true) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$true(true)";
  }
}

class $mixed implements Literal {
  const $mixed();
  const $mixed.validate(dynamic value)
    : assert(value == 'mixed', r"Value mismatch for $mixed");

  @override
  final value = 'mixed';

  @override
  bool operator ==(Object other) {
    if (other is $mixed) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$mixed(mixed)";
  }
}

class $text implements Literal {
  const $text();
  const $text.validate(dynamic value)
    : assert(value == 'text', r"Value mismatch for $text");

  @override
  final value = 'text';

  @override
  bool operator ==(Object other) {
    if (other is $text) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$text(text)";
  }
}

class $number implements Literal {
  const $number();
  const $number.validate(dynamic value)
    : assert(value == 'number', r"Value mismatch for $number");

  @override
  final value = 'number';

  @override
  bool operator ==(Object other) {
    if (other is $number) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$number(number)";
  }
}

class $boolean implements Literal {
  const $boolean();
  const $boolean.validate(dynamic value)
    : assert(value == 'boolean', r"Value mismatch for $boolean");

  @override
  final value = 'boolean';

  @override
  bool operator ==(Object other) {
    if (other is $boolean) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$boolean(boolean)";
  }
}

class $image implements Literal {
  const $image();
  const $image.validate(dynamic value)
    : assert(value == 'image', r"Value mismatch for $image");

  @override
  final value = 'image';

  @override
  bool operator ==(Object other) {
    if (other is $image) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$image(image)";
  }
}

class $list implements Literal {
  const $list();
  const $list.validate(dynamic value)
    : assert(value == 'list', r"Value mismatch for $list");

  @override
  final value = 'list';

  @override
  bool operator ==(Object other) {
    if (other is $list) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$list(list)";
  }
}

class $schedule implements Literal {
  const $schedule();
  const $schedule.validate(dynamic value)
    : assert(value == 'schedule', r"Value mismatch for $schedule");

  @override
  final value = 'schedule';

  @override
  bool operator ==(Object other) {
    if (other is $schedule) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$schedule(schedule)";
  }
}

class $webhook implements Literal {
  const $webhook();
  const $webhook.validate(dynamic value)
    : assert(value == 'webhook', r"Value mismatch for $webhook");

  @override
  final value = 'webhook';

  @override
  bool operator ==(Object other) {
    if (other is $webhook) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$webhook(webhook)";
  }
}

class $event implements Literal {
  const $event();
  const $event.validate(dynamic value)
    : assert(value == 'event', r"Value mismatch for $event");

  @override
  final value = 'event';

  @override
  bool operator ==(Object other) {
    if (other is $event) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$event(event)";
  }
}

class $A implements Literal {
  const $A();
  const $A.validate(dynamic value)
    : assert(value == 'A', r"Value mismatch for $A");

  @override
  final value = 'A';

  @override
  bool operator ==(Object other) {
    if (other is $A) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$A(A)";
  }
}

class $B implements Literal {
  const $B();
  const $B.validate(dynamic value)
    : assert(value == 'B', r"Value mismatch for $B");

  @override
  final value = 'B';

  @override
  bool operator ==(Object other) {
    if (other is $B) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$B(B)";
  }
}

class $foo implements Literal {
  const $foo();
  const $foo.validate(dynamic value)
    : assert(value == 'foo', r"Value mismatch for $foo");

  @override
  final value = 'foo';

  @override
  bool operator ==(Object other) {
    if (other is $foo) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$foo(foo)";
  }
}

class $123_0 implements Literal {
  const $123_0();
  const $123_0.validate(dynamic value)
    : assert(value == 123.0, r"Value mismatch for $123_0");

  @override
  final value = 123.0;

  @override
  bool operator ==(Object other) {
    if (other is $123_0) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$123_0(123)";
  }
}

class $false implements Literal {
  const $false();
  const $false.validate(dynamic value)
    : assert(value == false, r"Value mismatch for $false");

  @override
  final value = false;

  @override
  bool operator ==(Object other) {
    if (other is $false) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$false(false)";
  }
}

class $a implements Literal {
  const $a();
  const $a.validate(dynamic value)
    : assert(value == 'a', r"Value mismatch for $a");

  @override
  final value = 'a';

  @override
  bool operator ==(Object other) {
    if (other is $a) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$a(a)";
  }
}

class $helloworld implements Literal {
  const $helloworld();
  const $helloworld.validate(dynamic value)
    : assert(value == 'hello world', r"Value mismatch for $helloworld");

  @override
  final value = 'hello world';

  @override
  bool operator ==(Object other) {
    if (other is $helloworld) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$helloworld(hello world)";
  }
}

class $3_14 implements Literal {
  const $3_14();
  const $3_14.validate(dynamic value)
    : assert(value == 3.14, r"Value mismatch for $3_14");

  @override
  final value = 3.14;

  @override
  bool operator ==(Object other) {
    if (other is $3_14) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$3_14(3.14)";
  }
}

class $on implements Literal {
  const $on();
  const $on.validate(dynamic value)
    : assert(value == 'on', r"Value mismatch for $on");

  @override
  final value = 'on';

  @override
  bool operator ==(Object other) {
    if (other is $on) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$on(on)";
  }
}

class $_1_0 implements Literal {
  const $_1_0();
  const $_1_0.validate(dynamic value)
    : assert(value == -1.0, r"Value mismatch for $_1_0");

  @override
  final value = -1.0;

  @override
  bool operator ==(Object other) {
    if (other is $_1_0) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$_1_0(-1)";
  }
}

class $value implements Literal {
  const $value();
  const $value.validate(dynamic value)
    : assert(value == 'value', r"Value mismatch for $value");

  @override
  final value = 'value';

  @override
  bool operator ==(Object other) {
    if (other is $value) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$value(value)";
  }
}

class $ implements Literal {
  const $();
  const $.validate(dynamic value)
    : assert(value == '', r"Value mismatch for $");

  @override
  final value = '';

  @override
  bool operator ==(Object other) {
    if (other is $) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$()";
  }
}

class $blue implements Literal {
  const $blue();
  const $blue.validate(dynamic value)
    : assert(value == 'blue', r"Value mismatch for $blue");

  @override
  final value = 'blue';

  @override
  bool operator ==(Object other) {
    if (other is $blue) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$blue(blue)";
  }
}

class $red implements Literal {
  const $red();
  const $red.validate(dynamic value)
    : assert(value == 'red', r"Value mismatch for $red");

  @override
  final value = 'red';

  @override
  bool operator ==(Object other) {
    if (other is $red) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$red(red)";
  }
}

class $yes implements Literal {
  const $yes();
  const $yes.validate(dynamic value)
    : assert(value == 'yes', r"Value mismatch for $yes");

  @override
  final value = 'yes';

  @override
  bool operator ==(Object other) {
    if (other is $yes) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$yes(yes)";
  }
}

class $no implements Literal {
  const $no();
  const $no.validate(dynamic value)
    : assert(value == 'no', r"Value mismatch for $no");

  @override
  final value = 'no';

  @override
  bool operator ==(Object other) {
    if (other is $no) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$no(no)";
  }
}

class $2_0 implements Literal {
  const $2_0();
  const $2_0.validate(dynamic value)
    : assert(value == 2.0, r"Value mismatch for $2_0");

  @override
  final value = 2.0;

  @override
  bool operator ==(Object other) {
    if (other is $2_0) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$2_0(2)";
  }
}

class $3_0 implements Literal {
  const $3_0();
  const $3_0.validate(dynamic value)
    : assert(value == 3.0, r"Value mismatch for $3_0");

  @override
  final value = 3.0;

  @override
  bool operator ==(Object other) {
    if (other is $3_0) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$3_0(3)";
  }
}

class $admin implements Literal {
  const $admin();
  const $admin.validate(dynamic value)
    : assert(value == 'admin', r"Value mismatch for $admin");

  @override
  final value = 'admin';

  @override
  bool operator ==(Object other) {
    if (other is $admin) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$admin(admin)";
  }
}

class $user implements Literal {
  const $user();
  const $user.validate(dynamic value)
    : assert(value == 'user', r"Value mismatch for $user");

  @override
  final value = 'user';

  @override
  bool operator ==(Object other) {
    if (other is $user) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$user(user)";
  }
}

class $guest implements Literal {
  const $guest();
  const $guest.validate(dynamic value)
    : assert(value == 'guest', r"Value mismatch for $guest");

  @override
  final value = 'guest';

  @override
  bool operator ==(Object other) {
    if (other is $guest) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$guest(guest)";
  }
}

class $work implements Literal {
  const $work();
  const $work.validate(dynamic value)
    : assert(value == 'work', r"Value mismatch for $work");

  @override
  final value = 'work';

  @override
  bool operator ==(Object other) {
    if (other is $work) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$work(work)";
  }
}

class $personal implements Literal {
  const $personal();
  const $personal.validate(dynamic value)
    : assert(value == 'personal', r"Value mismatch for $personal");

  @override
  final value = 'personal';

  @override
  bool operator ==(Object other) {
    if (other is $personal) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$personal(personal)";
  }
}

class $urgent implements Literal {
  const $urgent();
  const $urgent.validate(dynamic value)
    : assert(value == 'urgent', r"Value mismatch for $urgent");

  @override
  final value = 'urgent';

  @override
  bool operator ==(Object other) {
    if (other is $urgent) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$urgent(urgent)";
  }
}

class $pending implements Literal {
  const $pending();
  const $pending.validate(dynamic value)
    : assert(value == 'pending', r"Value mismatch for $pending");

  @override
  final value = 'pending';

  @override
  bool operator ==(Object other) {
    if (other is $pending) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$pending(pending)";
  }
}

class $approved implements Literal {
  const $approved();
  const $approved.validate(dynamic value)
    : assert(value == 'approved', r"Value mismatch for $approved");

  @override
  final value = 'approved';

  @override
  bool operator ==(Object other) {
    if (other is $approved) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$approved(approved)";
  }
}

class $rejected implements Literal {
  const $rejected();
  const $rejected.validate(dynamic value)
    : assert(value == 'rejected', r"Value mismatch for $rejected");

  @override
  final value = 'rejected';

  @override
  bool operator ==(Object other) {
    if (other is $rejected) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$rejected(rejected)";
  }
}

class $string implements Literal {
  const $string();
  const $string.validate(dynamic value)
    : assert(value == 'string', r"Value mismatch for $string");

  @override
  final value = 'string';

  @override
  bool operator ==(Object other) {
    if (other is $string) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$string(string)";
  }
}

class $primitive implements Literal {
  const $primitive();
  const $primitive.validate(dynamic value)
    : assert(value == 'primitive', r"Value mismatch for $primitive");

  @override
  final value = 'primitive';

  @override
  bool operator ==(Object other) {
    if (other is $primitive) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$primitive(primitive)";
  }
}

class $object implements Literal {
  const $object();
  const $object.validate(dynamic value)
    : assert(value == 'object', r"Value mismatch for $object");

  @override
  final value = 'object';

  @override
  bool operator ==(Object other) {
    if (other is $object) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$object(object)";
  }
}

class $array implements Literal {
  const $array();
  const $array.validate(dynamic value)
    : assert(value == 'array', r"Value mismatch for $array");

  @override
  final value = 'array';

  @override
  bool operator ==(Object other) {
    if (other is $array) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$array(array)";
  }
}

class $green implements Literal {
  const $green();
  const $green.validate(dynamic value)
    : assert(value == 'green', r"Value mismatch for $green");

  @override
  final value = 'green';

  @override
  bool operator ==(Object other) {
    if (other is $green) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$green(green)";
  }
}

class $GET implements Literal {
  const $GET();
  const $GET.validate(dynamic value)
    : assert(value == 'GET', r"Value mismatch for $GET");

  @override
  final value = 'GET';

  @override
  bool operator ==(Object other) {
    if (other is $GET) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$GET(GET)";
  }
}

class $POST implements Literal {
  const $POST();
  const $POST.validate(dynamic value)
    : assert(value == 'POST', r"Value mismatch for $POST");

  @override
  final value = 'POST';

  @override
  bool operator ==(Object other) {
    if (other is $POST) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$POST(POST)";
  }
}

class $PUT implements Literal {
  const $PUT();
  const $PUT.validate(dynamic value)
    : assert(value == 'PUT', r"Value mismatch for $PUT");

  @override
  final value = 'PUT';

  @override
  bool operator ==(Object other) {
    if (other is $PUT) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$PUT(PUT)";
  }
}

class $DELETE implements Literal {
  const $DELETE();
  const $DELETE.validate(dynamic value)
    : assert(value == 'DELETE', r"Value mismatch for $DELETE");

  @override
  final value = 'DELETE';

  @override
  bool operator ==(Object other) {
    if (other is $DELETE) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$DELETE(DELETE)";
  }
}

class $minute implements Literal {
  const $minute();
  const $minute.validate(dynamic value)
    : assert(value == 'minute', r"Value mismatch for $minute");

  @override
  final value = 'minute';

  @override
  bool operator ==(Object other) {
    if (other is $minute) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$minute(minute)";
  }
}

class $hour implements Literal {
  const $hour();
  const $hour.validate(dynamic value)
    : assert(value == 'hour', r"Value mismatch for $hour");

  @override
  final value = 'hour';

  @override
  bool operator ==(Object other) {
    if (other is $hour) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$hour(hour)";
  }
}

class $day implements Literal {
  const $day();
  const $day.validate(dynamic value)
    : assert(value == 'day', r"Value mismatch for $day");

  @override
  final value = 'day';

  @override
  bool operator ==(Object other) {
    if (other is $day) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$day(day)";
  }
}

class $date implements Literal {
  const $date();
  const $date.validate(dynamic value)
    : assert(value == 'date', r"Value mismatch for $date");

  @override
  final value = 'date';

  @override
  bool operator ==(Object other) {
    if (other is $date) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$date(date)";
  }
}

class $action implements Literal {
  const $action();
  const $action.validate(dynamic value)
    : assert(value == 'action', r"Value mismatch for $action");

  @override
  final value = 'action';

  @override
  bool operator ==(Object other) {
    if (other is $action) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$action(action)";
  }
}

class $condition implements Literal {
  const $condition();
  const $condition.validate(dynamic value)
    : assert(value == 'condition', r"Value mismatch for $condition");

  @override
  final value = 'condition';

  @override
  bool operator ==(Object other) {
    if (other is $condition) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$condition(condition)";
  }
}

class $loop implements Literal {
  const $loop();
  const $loop.validate(dynamic value)
    : assert(value == 'loop', r"Value mismatch for $loop");

  @override
  final value = 'loop';

  @override
  bool operator ==(Object other) {
    if (other is $loop) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$loop(loop)";
  }
}

class $read implements Literal {
  const $read();
  const $read.validate(dynamic value)
    : assert(value == 'read', r"Value mismatch for $read");

  @override
  final value = 'read';

  @override
  bool operator ==(Object other) {
    if (other is $read) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$read(read)";
  }
}

class $write implements Literal {
  const $write();
  const $write.validate(dynamic value)
    : assert(value == 'write', r"Value mismatch for $write");

  @override
  final value = 'write';

  @override
  bool operator ==(Object other) {
    if (other is $write) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$write(write)";
  }
}

class $C implements Literal {
  const $C();
  const $C.validate(dynamic value)
    : assert(value == 'C', r"Value mismatch for $C");

  @override
  final value = 'C';

  @override
  bool operator ==(Object other) {
    if (other is $C) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$C(C)";
  }
}

class $off implements Literal {
  const $off();
  const $off.validate(dynamic value)
    : assert(value == 'off', r"Value mismatch for $off");

  @override
  final value = 'off';

  @override
  bool operator ==(Object other) {
    if (other is $off) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$off(off)";
  }
}

class $cat implements Literal {
  const $cat();
  const $cat.validate(dynamic value)
    : assert(value == 'cat', r"Value mismatch for $cat");

  @override
  final value = 'cat';

  @override
  bool operator ==(Object other) {
    if (other is $cat) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$cat(cat)";
  }
}

class $dog implements Literal {
  const $dog();
  const $dog.validate(dynamic value)
    : assert(value == 'dog', r"Value mismatch for $dog");

  @override
  final value = 'dog';

  @override
  bool operator ==(Object other) {
    if (other is $dog) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$dog(dog)";
  }
}
