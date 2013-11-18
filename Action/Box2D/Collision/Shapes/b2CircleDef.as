package Box2D.Collision.Shapes
{
    import Box2D.Common.Math.*;

    public class b2CircleDef extends b2ShapeDef
    {
        public var localPosition:b2Vec2;
        public var radius:Number;

        public function b2CircleDef()
        {
            localPosition = new b2Vec2(0, 0);
            type = b2Shape.e_circleShape;
            radius = 1;
            return;
        }// end function

    }
}
