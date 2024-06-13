import styles from './nav.module.css'
import { Button } from './ui/button';
const SideNavbar = () =>{
    return (
    
        
        <div className="fixed top-11 left-0 w-40 bg-blue-200 h-screen">
           <div className={styles.nav}>
             
             <button className={styles.btn}> settings</button>
             <button className={styles.btn}>Courses</button>
             <button className={styles.btn}>Assignment</button>
             <button className={styles.btn}>Announcements</button>
             <button className={styles.btn}>Resources</button>
             <button className={styles.btn}>Tests</button>
             
           </div>
            <div className={styles.nav}> 
           
            </div>
            </div>


    
        
        
    )
}

export default SideNavbar;