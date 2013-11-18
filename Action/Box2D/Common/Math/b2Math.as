package Box2D.Common.Math
{

    public class b2Math extends Object
    {
        public static const b2Mat22_identity:b2Mat22 = new b2Mat22(0, new b2Vec2(1, 0), new b2Vec2(0, 1));
        public static const b2XForm_identity:b2XForm = new b2XForm(b2Vec2_zero, b2Mat22_identity);
        public static const b2Vec2_zero:b2Vec2 = new b2Vec2(0, 0);

        public function b2Math()
        {
            return;
        }// end function

        public static function b2CrossVF(param1:b2Vec2, param2:Number) : b2Vec2
        {
            var _loc_3:* = null;
            _loc_3 = new b2Vec2(param2 * param1.y, (-param2) * param1.x);
            return _loc_3;
        }// end function

        public static function AddVV(param1:b2Vec2, param2:b2Vec2) : b2Vec2
        {
            var _loc_3:* = null;
            _loc_3 = new b2Vec2(param1.x + param2.x, param1.y + param2.y);
            return _loc_3;
        }// end function

        public static function b2IsValid(param1:Number) : Boolean
        {
            return isFinite(param1);
        }// end function

        public static function b2MinV(param1:b2Vec2, param2:b2Vec2) : b2Vec2
        {
            var _loc_3:* = null;
            _loc_3 = new b2Vec2(b2Min(param1.x, param2.x), b2Min(param1.y, param2.y));
            return _loc_3;
        }// end function

        public static function b2MulX(param1:b2XForm, param2:b2Vec2) : b2Vec2
        {
            var _loc_3:* = null;
            _loc_3 = b2MulMV(param1.R, param2);
            _loc_3.x = _loc_3.x + param1.position.x;
            _loc_3.y = _loc_3.y + param1.position.y;
            return _loc_3;
        }// end function

        public static function b2DistanceSquared(param1:b2Vec2, param2:b2Vec2) : Number
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            _loc_3 = param1.x - param2.x;
            _loc_4 = param1.y - param2.y;
            return _loc_3 * _loc_3 + _loc_4 * _loc_4;
        }// end function

        public static function b2Swap(param1:Array, param2:Array) : void
        {
            var _loc_3:* = undefined;
            _loc_3 = param1[0];
            param1[0] = param2[0];
            param2[0] = _loc_3;
            return;
        }// end function

        public static function b2AbsM(param1:b2Mat22) : b2Mat22
        {
            var _loc_2:* = null;
            _loc_2 = new b2Mat22(0, b2AbsV(param1.col1), b2AbsV(param1.col2));
            return _loc_2;
        }// end function

        public static function SubtractVV(param1:b2Vec2, param2:b2Vec2) : b2Vec2
        {
            var _loc_3:* = null;
            _loc_3 = new b2Vec2(param1.x - param2.x, param1.y - param2.y);
            return _loc_3;
        }// end function

        public static function b2MulXT(param1:b2XForm, param2:b2Vec2) : b2Vec2
        {
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            _loc_3 = SubtractVV(param2, param1.position);
            _loc_4 = _loc_3.x * param1.R.col1.x + _loc_3.y * param1.R.col1.y;
            _loc_3.y = _loc_3.x * param1.R.col2.x + _loc_3.y * param1.R.col2.y;
            _loc_3.x = _loc_4;
            return _loc_3;
        }// end function

        public static function b2Abs(param1:Number) : Number
        {
            return param1 > 0 ? (param1) : (-param1);
        }// end function

        public static function b2Clamp(param1:Number, param2:Number, param3:Number) : Number
        {
            return b2Max(param2, b2Min(param1, param3));
        }// end function

        public static function b2AbsV(param1:b2Vec2) : b2Vec2
        {
            var _loc_2:* = null;
            _loc_2 = new b2Vec2(b2Abs(param1.x), b2Abs(param1.y));
            return _loc_2;
        }// end function

        public static function MulFV(param1:Number, param2:b2Vec2) : b2Vec2
        {
            var _loc_3:* = null;
            _loc_3 = new b2Vec2(param1 * param2.x, param1 * param2.y);
            return _loc_3;
        }// end function

        public static function b2CrossVV(param1:b2Vec2, param2:b2Vec2) : Number
        {
            return param1.x * param2.y - param1.y * param2.x;
        }// end function

        public static function b2Dot(param1:b2Vec2, param2:b2Vec2) : Number
        {
            return param1.x * param2.x + param1.y * param2.y;
        }// end function

        public static function b2CrossFV(param1:Number, param2:b2Vec2) : b2Vec2
        {
            var _loc_3:* = null;
            _loc_3 = new b2Vec2((-param1) * param2.y, param1 * param2.x);
            return _loc_3;
        }// end function

        public static function AddMM(param1:b2Mat22, param2:b2Mat22) : b2Mat22
        {
            var _loc_3:* = null;
            _loc_3 = new b2Mat22(0, AddVV(param1.col1, param2.col1), AddVV(param1.col2, param2.col2));
            return _loc_3;
        }// end function

        public static function b2Distance(param1:b2Vec2, param2:b2Vec2) : Number
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            _loc_3 = param1.x - param2.x;
            _loc_4 = param1.y - param2.y;
            return Math.sqrt(_loc_3 * _loc_3 + _loc_4 * _loc_4);
        }// end function

        public static function b2MulTMM(param1:b2Mat22, param2:b2Mat22) : b2Mat22
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_3 = new b2Vec2(b2Dot(param1.col1, param2.col1), b2Dot(param1.col2, param2.col1));
            _loc_4 = new b2Vec2(b2Dot(param1.col1, param2.col2), b2Dot(param1.col2, param2.col2));
            _loc_5 = new b2Mat22(0, _loc_3, _loc_4);
            return _loc_5;
        }// end function

        public static function b2MaxV(param1:b2Vec2, param2:b2Vec2) : b2Vec2
        {
            var _loc_3:* = null;
            _loc_3 = new b2Vec2(b2Max(param1.x, param2.x), b2Max(param1.y, param2.y));
            return _loc_3;
        }// end function

        public static function b2IsPowerOfTwo(param1:uint) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = param1 > 0 && (param1 & (param1 - 1)) == 0;
            return _loc_2;
        }// end function

        public static function b2ClampV(param1:b2Vec2, param2:b2Vec2, param3:b2Vec2) : b2Vec2
        {
            return b2MaxV(param2, b2MinV(param1, param3));
        }// end function

        public static function b2RandomRange(param1:Number, param2:Number) : Number
        {
            var _loc_3:* = NaN;
            _loc_3 = Math.random();
            _loc_3 = (param2 - param1) * _loc_3 + param1;
            return _loc_3;
        }// end function

        public static function b2MulTMV(param1:b2Mat22, param2:b2Vec2) : b2Vec2
        {
            var _loc_3:* = null;
            _loc_3 = new b2Vec2(b2Dot(param2, param1.col1), b2Dot(param2, param1.col2));
            return _loc_3;
        }// end function

        public static function b2Min(param1:Number, param2:Number) : Number
        {
            return param1 < param2 ? (param1) : (param2);
        }// end function

        public static function b2Random() : Number
        {
            return Math.random() * 2 - 1;
        }// end function

        public static function b2MulMM(param1:b2Mat22, param2:b2Mat22) : b2Mat22
        {
            var _loc_3:* = null;
            _loc_3 = new b2Mat22(0, b2MulMV(param1, param2.col1), b2MulMV(param1, param2.col2));
            return _loc_3;
        }// end function

        public static function b2NextPowerOfTwo(param1:uint) : uint
        {
            param1 = param1 | param1 >> 1 & 2147483647;
            param1 = param1 | param1 >> 2 & 1073741823;
            param1 = param1 | param1 >> 4 & 268435455;
            param1 = param1 | param1 >> 8 & 16777215;
            param1 = param1 | param1 >> 16 & 65535;
            return (param1 + 1);
        }// end function

        public static function b2Max(param1:Number, param2:Number) : Number
        {
            return param1 > param2 ? (param1) : (param2);
        }// end function

        public static function b2MulMV(param1:b2Mat22, param2:b2Vec2) : b2Vec2
        {
            var _loc_3:* = null;
            _loc_3 = new b2Vec2(param1.col1.x * param2.x + param1.col2.x * param2.y, param1.col1.y * param2.x + param1.col2.y * param2.y);
            return _loc_3;
        }// end function

    }
}
