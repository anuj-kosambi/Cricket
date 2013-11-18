package Box2D.Common.Math
{

    public class b2Sweep extends Object
    {
        public var localCenter:b2Vec2;
        public var c:b2Vec2;
        public var a:Number;
        public var c0:b2Vec2;
        public var a0:Number;
        public var t0:Number;

        public function b2Sweep()
        {
            localCenter = new b2Vec2();
            c0 = new b2Vec2();
            c = new b2Vec2();
            return;
        }// end function

        public function Advance(param1:Number) : void
        {
            var _loc_2:* = NaN;
            if (t0 < param1 && 1 - t0 > Number.MIN_VALUE)
            {
                _loc_2 = (param1 - t0) / (1 - t0);
                c0.x = (1 - _loc_2) * c0.x + _loc_2 * c.x;
                c0.y = (1 - _loc_2) * c0.y + _loc_2 * c.y;
                a0 = (1 - _loc_2) * a0 + _loc_2 * a;
                t0 = param1;
            }
            return;
        }// end function

        public function GetXForm(param1:b2XForm, param2:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            if (1 - t0 > Number.MIN_VALUE)
            {
                _loc_4 = (param2 - t0) / (1 - t0);
                param1.position.x = (1 - _loc_4) * c0.x + _loc_4 * c.x;
                param1.position.y = (1 - _loc_4) * c0.y + _loc_4 * c.y;
                _loc_5 = (1 - _loc_4) * a0 + _loc_4 * a;
                param1.R.Set(_loc_5);
            }
            else
            {
                param1.position.SetV(c);
                param1.R.Set(a);
            }
            _loc_3 = param1.R;
            param1.position.x = param1.position.x - (_loc_3.col1.x * localCenter.x + _loc_3.col2.x * localCenter.y);
            param1.position.y = param1.position.y - (_loc_3.col1.y * localCenter.x + _loc_3.col2.y * localCenter.y);
            return;
        }// end function

    }
}
