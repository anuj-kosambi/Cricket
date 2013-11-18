package Box2D.Dynamics
{
    import Box2D.Collision.Shapes.*;

    public class b2ContactFilter extends Object
    {
        public static var b2_defaultFilter:b2ContactFilter = new b2ContactFilter;

        public function b2ContactFilter()
        {
            return;
        }// end function

        public function ShouldCollide(param1:b2Shape, param2:b2Shape) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = false;
            _loc_3 = param1.GetFilterData();
            _loc_4 = param2.GetFilterData();
            if (_loc_3.groupIndex == _loc_4.groupIndex && _loc_3.groupIndex != 0)
            {
                return _loc_3.groupIndex > 0;
            }
            _loc_5 = (_loc_3.maskBits & _loc_4.categoryBits) != 0 && (_loc_3.categoryBits & _loc_4.maskBits) != 0;
            return _loc_5;
        }// end function

    }
}
