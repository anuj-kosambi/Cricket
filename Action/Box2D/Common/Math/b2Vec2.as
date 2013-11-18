package Box2D.Common.Math
{

    public class b2Vec2 extends Object
    {
        public var x:Number;
        public var y:Number;

        public function b2Vec2(param1:Number = 0, param2:Number = 0) : void
        {
            x = param1;
            y = param2;
            return;
        }// end function

        public function Set(param1:Number = 0, param2:Number = 0) : void
        {
            x = param1;
            y = param2;
            return;
        }// end function

        public function Multiply(param1:Number) : void
        {
            x = x * param1;
            y = y * param1;
            return;
        }// end function

        public function Length() : Number
        {
            return Math.sqrt(x * x + y * y);
        }// end function

        public function LengthSquared() : Number
        {
            return x * x + y * y;
        }// end function

        public function SetZero() : void
        {
            x = 0;
            y = 0;
            return;
        }// end function

        public function Add(param1:b2Vec2) : void
        {
            x = x + param1.x;
            y = y + param1.y;
            return;
        }// end function

        public function MaxV(param1:b2Vec2) : void
        {
            x = x > param1.x ? (x) : (param1.x);
            y = y > param1.y ? (y) : (param1.y);
            return;
        }// end function

        public function SetV(param1:b2Vec2) : void
        {
            x = param1.x;
            y = param1.y;
            return;
        }// end function

        public function Negative() : b2Vec2
        {
            return new b2Vec2(-x, -y);
        }// end function

        public function CrossVF(param1:Number) : void
        {
            var _loc_2:* = NaN;
            _loc_2 = x;
            x = param1 * y;
            y = (-param1) * _loc_2;
            return;
        }// end function

        public function Abs() : void
        {
            if (x < 0)
            {
                x = -x;
            }
            if (y < 0)
            {
                y = -y;
            }
            return;
        }// end function

        public function Copy() : b2Vec2
        {
            return new b2Vec2(x, y);
        }// end function

        public function MulTM(param1:b2Mat22) : void
        {
            var _loc_2:* = NaN;
            _loc_2 = b2Math.b2Dot(this, param1.col1);
            y = b2Math.b2Dot(this, param1.col2);
            x = _loc_2;
            return;
        }// end function

        public function IsValid() : Boolean
        {
            return b2Math.b2IsValid(x) && b2Math.b2IsValid(y);
        }// end function

        public function MinV(param1:b2Vec2) : void
        {
            x = x < param1.x ? (x) : (param1.x);
            y = y < param1.y ? (y) : (param1.y);
            return;
        }// end function

        public function MulM(param1:b2Mat22) : void
        {
            var _loc_2:* = NaN;
            _loc_2 = x;
            x = param1.col1.x * _loc_2 + param1.col2.x * y;
            y = param1.col1.y * _loc_2 + param1.col2.y * y;
            return;
        }// end function

        public function Normalize() : Number
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            _loc_1 = Math.sqrt(x * x + y * y);
            if (_loc_1 < Number.MIN_VALUE)
            {
                return 0;
            }
            _loc_2 = 1 / _loc_1;
            x = x * _loc_2;
            y = y * _loc_2;
            return _loc_1;
        }// end function

        public function Subtract(param1:b2Vec2) : void
        {
            x = x - param1.x;
            y = y - param1.y;
            return;
        }// end function

        public function CrossFV(param1:Number) : void
        {
            var _loc_2:* = NaN;
            _loc_2 = x;
            x = (-param1) * y;
            y = param1 * _loc_2;
            return;
        }// end function

        public static function Make(param1:Number, param2:Number) : b2Vec2
        {
            return new b2Vec2(param1, param2);
        }// end function

    }
}
