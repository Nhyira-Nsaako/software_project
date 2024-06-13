import SideNavbar from "@/components/SideNavbar";



import styles from './admin.module.css'
const page = () => {
  return (
    <><div className="bg-custom-image">
      Admin page - Welcome back
    </div>
    <div className={styles.sidenavbar}>
        <SideNavbar></SideNavbar>
      </div></>
  )
}

export default page;