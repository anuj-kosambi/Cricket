package Box2D.Collision
{
    import Box2D.Common.Math.*;

    public class b2AABB extends Object
    {
        public var upperBound:b2Vec2;
        public var lowerBound:b2Vec2;

        public function b2AABB()
        {
            lowerBound = new b2Vec2();
            upperBound = new b2Vec2();
            return;
        }// end function

        public function IsValid() : Boolean
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = false;
            _loc_1 = upperBound.x - lowerBound.x;
            _loc_2 = upperBound.y - lowerBound.y;
            _loc_3 = _loc_1 >= 0 && _loc_2 >= 0;
            _loc_3 = _loc_3 && lowerBound.IsValid() && upperBound.IsValid();
            return _loc_3;
        }// end function

    }
}
