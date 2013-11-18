package Box2D.Collision
{
    import Box2D.Common.Math.*;

    public class ClipVertex extends Object
    {
        public var v:b2Vec2;
        public var id:b2ContactID;

        public function ClipVertex()
        {
            v = new b2Vec2();
            id = new b2ContactID();
            return;
        }// end function

    }
}
