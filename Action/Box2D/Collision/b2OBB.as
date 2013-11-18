package Box2D.Collision
{
    import Box2D.Common.Math.*;

    public class b2OBB extends Object
    {
        public var R:b2Mat22;
        public var center:b2Vec2;
        public var extents:b2Vec2;

        public function b2OBB()
        {
            R = new b2Mat22();
            center = new b2Vec2();
            extents = new b2Vec2();
            return;
        }// end function

    }
}
