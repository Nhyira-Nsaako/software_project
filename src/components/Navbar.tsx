import { buttonVariants } from "./ui/button";
import Link from "next/link";

const Navbar = () => {
    return (
        <div className="bg-pink-100 py-2 border-b border-s-grey-200 fixed w-full z-10 top-0">
            <div className="container flex items-center justify-between">
                <Link href="/">School of Engineering</Link>
                <Link className={buttonVariants()}  href="/sign-in">Sign in</Link>
            </div>
        </div>
    )
};

export default Navbar;