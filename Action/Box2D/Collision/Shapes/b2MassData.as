package Box2D.Collision.Shapes
{
    import Box2D.Common.Math.*;

    public class b2MassData extends Object
    {
        public var mass:Number = 0;
        public var center:b2Vec2;
        public var I:Number = 0;

        public function b2MassData()
        {
            mass = 0;
            center = new b2Vec2(0, 0);
            I = 0;
            return;
        }// end function

    }
}
