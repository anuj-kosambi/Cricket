package Box2D.Collision
{

    public class b2Bound extends Object
    {
        public var proxyId:uint;
        public var stabbingCount:uint;
        public var value:uint;

        public function b2Bound()
        {
            return;
        }// end function

        public function Swap(param1:b2Bound) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            _loc_2 = value;
            _loc_3 = proxyId;
            _loc_4 = stabbingCount;
            value = param1.value;
            proxyId = param1.proxyId;
            stabbingCount = param1.stabbingCount;
            param1.value = _loc_2;
            param1.proxyId = _loc_3;
            param1.stabbingCount = _loc_4;
            return;
        }// end function

        public function IsLower() : Boolean
        {
            return (value & 1) == 0;
        }// end function

        public function IsUpper() : Boolean
        {
            return (value & 1) == 1;
        }// end function

    }
}
