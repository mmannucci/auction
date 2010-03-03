package it.solvingteam.auction.domain;

import it.solvingteam.auction.domain.ItemDataOnDemand;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect ItemIntegrationTest_Roo_IntegrationTest {
    
    declare @type: ItemIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: ItemIntegrationTest: @ContextConfiguration(locations = "classpath:/META-INF/spring/applicationContext.xml");
    
    @Autowired
    private ItemDataOnDemand ItemIntegrationTest.dod;
    
    @Test
    public void ItemIntegrationTest.testCountItems() {
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to initialize correctly", dod.getRandomItem());
        long count = it.solvingteam.auction.domain.Item.countItems();
        org.junit.Assert.assertTrue("Counter for 'Item' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void ItemIntegrationTest.testFindItem() {
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to initialize correctly", dod.getRandomItem());
        java.lang.Long id = dod.getRandomItem().getId();
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to provide an identifier", id);
        it.solvingteam.auction.domain.Item obj = it.solvingteam.auction.domain.Item.findItem(id);
        org.junit.Assert.assertNotNull("Find method for 'Item' illegally returned null for id '" + id + "'", obj);
        org.junit.Assert.assertEquals("Find method for 'Item' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void ItemIntegrationTest.testFindAllItems() {
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to initialize correctly", dod.getRandomItem());
        long count = it.solvingteam.auction.domain.Item.countItems();
        org.junit.Assert.assertTrue("Too expensive to perform a find all test for 'Item', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        java.util.List<it.solvingteam.auction.domain.Item> result = it.solvingteam.auction.domain.Item.findAllItems();
        org.junit.Assert.assertNotNull("Find all method for 'Item' illegally returned null", result);
        org.junit.Assert.assertTrue("Find all method for 'Item' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void ItemIntegrationTest.testFindItemEntries() {
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to initialize correctly", dod.getRandomItem());
        long count = it.solvingteam.auction.domain.Item.countItems();
        if (count > 20) count = 20;
        java.util.List<it.solvingteam.auction.domain.Item> result = it.solvingteam.auction.domain.Item.findItemEntries(0, (int)count);
        org.junit.Assert.assertNotNull("Find entries method for 'Item' illegally returned null", result);
        org.junit.Assert.assertEquals("Find entries method for 'Item' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    @Transactional
    public void ItemIntegrationTest.testFlush() {
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to initialize correctly", dod.getRandomItem());
        java.lang.Long id = dod.getRandomItem().getId();
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to provide an identifier", id);
        it.solvingteam.auction.domain.Item obj = it.solvingteam.auction.domain.Item.findItem(id);
        org.junit.Assert.assertNotNull("Find method for 'Item' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyItem(obj);
        java.lang.Integer currentVersion = obj.getVersion();
        obj.flush();
        org.junit.Assert.assertTrue("Version for 'Item' failed to increment on flush directive", obj.getVersion() > currentVersion || !modified);
    }
    
    @Test
    @Transactional
    public void ItemIntegrationTest.testMerge() {
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to initialize correctly", dod.getRandomItem());
        java.lang.Long id = dod.getRandomItem().getId();
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to provide an identifier", id);
        it.solvingteam.auction.domain.Item obj = it.solvingteam.auction.domain.Item.findItem(id);
        org.junit.Assert.assertNotNull("Find method for 'Item' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyItem(obj);
        java.lang.Integer currentVersion = obj.getVersion();
        obj.merge();
        obj.flush();
        org.junit.Assert.assertTrue("Version for 'Item' failed to increment on merge and flush directive", obj.getVersion() > currentVersion || !modified);
    }
    
    @Test
    @Transactional
    public void ItemIntegrationTest.testPersist() {
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to initialize correctly", dod.getRandomItem());
        it.solvingteam.auction.domain.Item obj = dod.getNewTransientItem(Integer.MAX_VALUE);
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to provide a new transient entity", obj);
        org.junit.Assert.assertNull("Expected 'Item' identifier to be null", obj.getId());
        obj.persist();
        obj.flush();
        org.junit.Assert.assertNotNull("Expected 'Item' identifier to no longer be null", obj.getId());
    }
    
    @Test
    @Transactional
    public void ItemIntegrationTest.testRemove() {
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to initialize correctly", dod.getRandomItem());
        java.lang.Long id = dod.getRandomItem().getId();
        org.junit.Assert.assertNotNull("Data on demand for 'Item' failed to provide an identifier", id);
        it.solvingteam.auction.domain.Item obj = it.solvingteam.auction.domain.Item.findItem(id);
        org.junit.Assert.assertNotNull("Find method for 'Item' illegally returned null for id '" + id + "'", obj);
        obj.remove();
        org.junit.Assert.assertNull("Failed to remove 'Item' with identifier '" + id + "'", it.solvingteam.auction.domain.Item.findItem(id));
    }
    
}
