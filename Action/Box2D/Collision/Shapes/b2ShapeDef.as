package Box2D.Collision.Shapes
{

    public class b2ShapeDef extends Object
    {
        public var isSensor:Boolean = false;
        public var density:Number = 0;
        public var type:int;
        public var restitution:Number = 0;
        public var userData:Object = null;
        public var filter:b2FilterData;
        public var friction:Number = 0.2;

        public function b2ShapeDef()
        {
            type = b2Shape.e_unknownShape;
            userData = null;
            friction = 0.2;
            restitution = 0;
            density = 0;
            isSensor = false;
            filter = new b2FilterData();
            return;
        }// end function

    }
}
